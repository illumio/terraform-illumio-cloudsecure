data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# Data source to get the AWS org, used for the organization trail's bucket policy path.
data "aws_organizations_organization" "current" {
  count = var.create_s3_bucket && var.is_organization_trail && var.organization_id == null ? 1 : 0
}

locals {
  # Built from its parts instead of aws_cloudtrail.this.arn: the bucket policy must
  # exist before the trail is created, so referencing the resource would be a cycle.
  trail_arn       = "arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:trail/${var.name}"
  organization_id = var.is_organization_trail ? (var.organization_id != null ? var.organization_id : one(data.aws_organizations_organization.current[*].id)) : null
  log_prefix      = var.s3_key_prefix == null || var.s3_key_prefix == "" ? "" : "${var.s3_key_prefix}/"
}

module "log_bucket" {
  source = "../aws_cloudtrail_s3_bucket"
  count  = var.create_s3_bucket ? 1 : 0

  bucket_name     = var.s3_bucket_name
  trail_arn       = local.trail_arn
  log_account_id  = data.aws_caller_identity.current.account_id
  s3_key_prefix   = var.s3_key_prefix
  organization_id = local.organization_id

  cross_account_reader_arns    = var.cross_account_reader_arns
  cross_account_reader_actions = var.cross_account_reader_actions

  force_destroy            = var.bucket_force_destroy
  versioning_enabled       = var.bucket_versioning_enabled
  sse_algorithm            = var.bucket_sse_algorithm
  kms_master_key_id        = var.bucket_kms_master_key_id
  bucket_key_enabled       = var.bucket_key_enabled
  blocked_encryption_types = var.bucket_blocked_encryption_types

  tags = var.tags
}

resource "aws_cloudtrail" "this" {
  name           = var.name
  s3_bucket_name = var.s3_bucket_name
  s3_key_prefix  = var.s3_key_prefix

  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  is_organization_trail         = var.is_organization_trail
  enable_log_file_validation    = var.enable_log_file_validation
  enable_logging                = var.enable_logging

  kms_key_id                 = var.kms_key_id
  sns_topic_name             = var.sns_topic_name
  cloud_watch_logs_group_arn = var.cloud_watch_logs_group_arn
  cloud_watch_logs_role_arn  = var.cloud_watch_logs_role_arn

  dynamic "advanced_event_selector" {
    for_each = var.advanced_event_selectors

    content {
      name = advanced_event_selector.value.name

      dynamic "field_selector" {
        for_each = advanced_event_selector.value.field_selector

        content {
          field           = field_selector.value.field
          equals          = field_selector.value.equals
          not_equals      = field_selector.value.not_equals
          starts_with     = field_selector.value.starts_with
          not_starts_with = field_selector.value.not_starts_with
          ends_with       = field_selector.value.ends_with
          not_ends_with   = field_selector.value.not_ends_with
        }
      }
    }
  }

  dynamic "insight_selector" {
    for_each = toset(var.insight_types)

    content {
      insight_type = insight_selector.value
    }
  }

  tags = var.tags

  # CloudTrail validates bucket permissions at creation time.
  depends_on = [module.log_bucket]
}
