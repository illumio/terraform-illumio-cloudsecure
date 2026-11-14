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
}
