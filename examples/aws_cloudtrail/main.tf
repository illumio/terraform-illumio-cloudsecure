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
  name           = "example-trail"
  s3_bucket_name = module.aws_cloudtrail_s3_bucket_dev.s3_bucket_name

  # Optional attributes
  is_multi_region_trail = true
  s3_key_prefix         = module.aws_cloudtrail_s3_bucket_dev.s3_key_prefix

  tags = {
    Name  = "CloudSecure CloudTrail"
    Owner = "Engineering"
  }
}
