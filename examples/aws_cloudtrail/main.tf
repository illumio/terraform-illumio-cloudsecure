provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_cloudtrail_dev" {
  source         = "illumio/cloudsecure/illumio//modules/aws_cloudtrail"
  version        = "1.7.0"
  name           = "example-trail"
  s3_bucket_name = var.s3_bucket_name

  # Optional attributes
  cross_account_reader_arns = ["arn:aws:iam::123456789012:role/ExampleLogReaderRole"]
  is_multi_region_trail     = true
  s3_key_prefix             = "cloudtrail"

  tags = {
    Name  = "CloudSecure CloudTrail"
    Owner = "Engineering"
  }
}
