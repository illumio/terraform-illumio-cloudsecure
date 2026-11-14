provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_cloudtrail_s3_bucket_dev" {
  source     = "illumio/cloudsecure/illumio//modules/aws_cloudtrail_s3_bucket"
  version    = "1.7.1"
  name       = "example-cloudtrail-logs"
  trail_name = "example-trail"

  # Optional attributes
  cross_account_reader_arns = ["arn:aws:iam::123456789012:role/ExampleLogReaderRole"]
  s3_key_prefix             = "cloudtrail"

  tags = {
    Name  = "CloudSecure CloudTrail"
    Owner = "Engineering"
  }
}

module "aws_cloudtrail_dev" {
  source         = "illumio/cloudsecure/illumio//modules/aws_cloudtrail"
  version        = "1.7.1"
  name           = module.aws_cloudtrail_s3_bucket_dev.trail_name
  s3_bucket_name = module.aws_cloudtrail_s3_bucket_dev.s3_bucket_name

  # Optional attributes
  # For best threat detection, we recommend enabling all these events, but
  # threat detection still works with only management events enabled.
  advanced_event_selectors = [
    {
      field_selector = [
        { field = "eventCategory", equals = ["Data"] },
        { field = "resources.type", equals = ["AWS::S3::Object"] }
      ]
    },
    {
      field_selector = [
        { field = "eventCategory", equals = ["Data"] },
        { field = "resources.type", equals = ["AWS::DynamoDB::Table"] }
      ]
    },
    {
      field_selector = [
        { field = "eventCategory", equals = ["Data"] },
        { field = "resources.type", equals = ["AWS::DSQL::Cluster"] }
      ]
    },
    {
      field_selector = [
        { field = "eventCategory", equals = ["Data"] },
        { field = "resources.type", equals = ["AWS::Lambda::Function"] }
      ]
    },
    {
      field_selector = [
        { field = "eventCategory", equals = ["Data"] },
        { field = "resources.type", equals = ["AWS::RDS::DBCluster"] }
      ]
    },
    {
      name = "Management events selector"
      field_selector = [
        { field = "eventCategory", equals = ["Management"] }
      ]
    }
  ]
  cloud_watch_logs_group_arn    = "arn:aws:logs:us-west-1:111122223333:log-group:example-cloudtrail-log-group:*"
  cloud_watch_logs_role_arn     = "arn:aws:iam::111122223333:role/ExampleCloudTrailCloudWatchLogsRole"
  enable_log_file_validation    = true
  enable_logging                = true
  include_global_service_events = true
  insight_types                 = [] # May contain "ApiCallRateInsight" and/or "ApiErrorRateInsight"
  # It's recommended to use multi-Region trails for better threat detection.
  is_multi_region_trail = true
  is_organization_trail = false
  kms_key_id            = "arn:aws:kms:us-west-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  s3_key_prefix         = module.aws_cloudtrail_s3_bucket_dev.s3_key_prefix
  sns_topic_name        = "example-cloudtrail-notifications"

  tags = {
    Name  = "CloudSecure CloudTrail"
    Owner = "Engineering"
  }
}
