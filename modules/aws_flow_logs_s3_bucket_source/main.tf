locals {
  account_id = var.account_id != null ? var.account_id : data.aws_caller_identity.current[0].account_id
  partition  = data.aws_partition.current.partition

  # A stable, unique key per registered source. account_id is constant for the
  # module call, so (bucket_name, path_prefix) is the source identity.
  buckets_by_key = {
    for b in var.buckets :
    "${b.bucket_name}${b.path_prefix == null ? "" : "::${b.path_prefix}"}" => b
  }

  grant_read_access = var.role_id != null
}

data "aws_partition" "current" {}

data "aws_caller_identity" "current" {
  count = var.account_id == null ? 1 : 0
}

# Optionally create each bucket and allow VPC flow log delivery to it. Disabled
# by default: customers usually already have flow logs writing to the bucket.
resource "aws_s3_bucket" "this" {
  for_each = var.create_bucket ? local.buckets_by_key : {}
  bucket   = each.value.bucket_name
  tags     = var.tags
}

resource "aws_s3_bucket_policy" "flow_logs_delivery" {
  for_each = var.create_bucket ? local.buckets_by_key : {}
  bucket   = aws_s3_bucket.this[each.key].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AWSLogDeliveryAclCheck"
        Effect    = "Allow"
        Principal = { Service = "delivery.logs.amazonaws.com" }
        Action    = ["s3:GetBucketAcl", "s3:ListBucket"]
        Resource  = "arn:${local.partition}:s3:::${each.value.bucket_name}"
        Condition = {
          StringEquals = { "aws:SourceAccount" = local.account_id }
          ArnLike      = { "aws:SourceArn" = "arn:${local.partition}:logs:*:${local.account_id}:*" }
        }
      },
      {
        Sid       = "AWSLogDeliveryWrite"
        Effect    = "Allow"
        Principal = { Service = "delivery.logs.amazonaws.com" }
        Action    = "s3:PutObject"
        Resource  = "arn:${local.partition}:s3:::${each.value.bucket_name}/${each.value.path_prefix == null ? "" : "${trimsuffix(each.value.path_prefix, "/")}/"}AWSLogs/${local.account_id}/*"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = local.account_id
            "s3:x-amz-acl"      = "bucket-owner-full-control"
          }
          ArnLike = { "aws:SourceArn" = "arn:${local.partition}:logs:*:${local.account_id}:*" }
        }
      }
    ]
  })
}

# Optionally grant the CloudSecure IAM role read access to the registered buckets.
resource "aws_iam_role_policy" "read" {
  count = local.grant_read_access ? 1 : 0
  name  = "${var.iam_name_prefix}FlowLogsSourceReadPolicy"
  role  = var.role_id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat(
      [
        for b in local.buckets_by_key : {
          Effect   = "Allow"
          Action   = ["s3:ListBucket", "s3:GetBucketLocation"]
          Resource = "arn:${local.partition}:s3:::${b.bucket_name}"
        }
      ],
      [
        for b in local.buckets_by_key : {
          Effect   = "Allow"
          Action   = ["s3:GetObject"]
          Resource = "arn:${local.partition}:s3:::${b.bucket_name}/${b.path_prefix == null ? "" : "${trimsuffix(b.path_prefix, "/")}/"}*"
        }
      ]
    )
  })
}

# Register each existing bucket with CloudSecure by name and (optional) prefix.
resource "illumio-cloudsecure_aws_flow_logs_s3_bucket_source" "this" {
  for_each    = local.buckets_by_key
  account_id  = local.account_id
  bucket_name = each.value.bucket_name
  path_prefix = each.value.path_prefix

  depends_on = [aws_s3_bucket.this]
}
