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
  trail_region              = "us-west-2"

  tags = {
    Name  = "CloudSecure CloudTrail"
    Owner = "Engineering"
  }
}
