locals {
  all_arns_suffixed = [for arn in var.s3_bucket_arns : replace("${arn}/*", "//*", "/*")]
  arns_without_path = tolist(toset([for bucket in var.s3_bucket_arns : bucket if can(regex("^[^/]+$", bucket))]))
  arns_with_path_suffix = [for arn in var.s3_bucket_arns : arn if !can(regex("^[^/]+$", arn))]
  arns_of_buckets_with_path_suffix = [for arn in local.arns_with_path_suffix : regex("^[^/]+", arn)]
}

resource "aws_iam_role_policy" "s3_bucket_list" {
  name   = "${var.iam_name_prefix}BucketListPolicy"
  role   = var.role_id
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = concat([
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        Resource = local.arns_without_path
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketLocation"
        ],
        Resource = local.arns_of_buckets_with_path_suffix
      }
    ],
    [
      for arn in local.arns_with_path_suffix : {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
        ],
        Resource = regex("^[^/]+", arn)
        Condition = {
          StringLike = {
            "s3:prefix" = [
              replace("${regex("/.*/.*", arn)}/*", "//*", "/*")
            ]
          }
        }
      }
    ])
  })
}

resource "aws_iam_role_policy" "s3_bucket_read" {
  name   = "${var.iam_name_prefix}BucketReadPolicy"
  role   = var.role_id
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = concat([
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ],
        Resource = local.all_arns_suffixed
      }
    ])
  })
}

data "aws_caller_identity" "current" {}

resource "illumio-cloudsecure_aws_flow_logs_s3_bucket" "bucket_example" {
  for_each      = var.s3_bucket_arns
  account_id    = data.aws_caller_identity.current.account_id
  s3_bucket_arn = each.key
}
