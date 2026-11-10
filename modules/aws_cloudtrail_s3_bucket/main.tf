data "aws_partition" "current" {}

# Data source to get the AWS account ID.
data "aws_caller_identity" "current" {}

# Data source to get the AWS org, used for the organization trail's bucket policy.
data "aws_organizations_organization" "current" {
  count                    = var.is_organization_trail ? 1 : 0
  return_organization_only = true
}

locals {
  # An organization trail belongs to the management account even when a delegated
  # administrator creates it, so the bucket policy must use that account's ID.
  trail_account_id = var.is_organization_trail ? one(data.aws_organizations_organization.current[*].master_account_id) : data.aws_caller_identity.current.account_id
  # Built from its parts instead of read from the trail: the bucket policy must exist
  # before the trail is created, so taking the ARN from the trail would be a cycle.
  trail_arn       = "arn:${data.aws_partition.current.partition}:cloudtrail:${coalesce(var.trail_region, aws_s3_bucket.this.region)}:${local.trail_account_id}:trail/${var.trail_name}"
  organization_id = one(data.aws_organizations_organization.current[*].id)
  bucket_arn      = "arn:${data.aws_partition.current.partition}:s3:::${var.name}"
  log_prefix      = var.s3_key_prefix == null || var.s3_key_prefix == "" ? "" : "${var.s3_key_prefix}/"
  write_resources = concat(
    ["${local.bucket_arn}/${local.log_prefix}AWSLogs/${local.trail_account_id}/*"],
    local.organization_id == null ? [] : ["${local.bucket_arn}/${local.log_prefix}AWSLogs/${local.organization_id}/*"]
  )
}

resource "aws_s3_bucket" "this" {
  bucket        = var.name
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
      kms_master_key_id = var.sse_algorithm == "aws:kms" ? var.kms_master_key_id : null
    }
    bucket_key_enabled       = var.bucket_key_enabled
    blocked_encryption_types = var.blocked_encryption_types
  }
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.versioning_enabled ? 1 : 0
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    sid     = "AWSCloudTrailAclCheck20150319"
    effect  = "Allow"
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [local.bucket_arn]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [local.trail_arn]
    }
  }

  statement {
    sid     = "AWSCloudTrailWrite20150319"
    effect  = "Allow"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = local.write_resources
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [local.trail_arn]
    }
  }

  dynamic "statement" {
    for_each = length(var.cross_account_reader_arns) > 0 ? [1] : []
    content {
      sid     = "AllowCrossAccountRoleAccess"
      effect  = "Allow"
      actions = var.cross_account_reader_actions
      principals {
        type        = "AWS"
        identifiers = var.cross_account_reader_arns
      }
      resources = [local.bucket_arn, "${local.bucket_arn}/*"]
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json

  depends_on = [aws_s3_bucket_public_access_block.this]
}

# Registers the bucket with CloudSecure only once its policy is in place, so that the
# read access granted through cross_account_reader_arns is effective at registration time.
resource "illumio-cloudsecure_aws_cloudtrail_s3_bucket" "this" {
  account_id    = data.aws_caller_identity.current.account_id
  s3_bucket_arn = aws_s3_bucket.this.arn

  depends_on = [aws_s3_bucket_policy.this]
}
