provider "aws" {
  region = "us-west-1"
}

# The log bucket may live in another Region than the trail. A module cannot select
# a provider conditionally, so the bucket is created with an aliased provider and
# handed to the trail module with create_s3_bucket = false.
provider "aws" {
  alias  = "log_bucket"
  region = "us-west-2"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

data "aws_caller_identity" "current" {}

locals {
  trail_name = "example-trail"
  # The bucket policy must exist before the trail is created, so the trail ARN is
  # built from its parts rather than read back from the trail module.
  trail_arn = "arn:aws:cloudtrail:us-west-1:${data.aws_caller_identity.current.account_id}:trail/${local.trail_name}"
}

module "aws_cloudtrail_s3_bucket_dev" {
  source  = "illumio/cloudsecure/illumio//modules/aws_cloudtrail_s3_bucket"
  version = "1.7.0"
  providers = {
    aws = aws.log_bucket
  }
  bucket_name = var.s3_bucket_name
  trail_arn   = local.trail_arn

  # Optional attributes
  cross_account_reader_arns = ["arn:aws:iam::123456789012:role/ExampleLogReaderRole"]

  tags = {
    Name  = "CloudSecure CloudTrail"
    Owner = "Engineering"
  }
}

module "aws_cloudtrail_dev" {
  source         = "illumio/cloudsecure/illumio//modules/aws_cloudtrail"
  version        = "1.7.0"
  name           = local.trail_name
  s3_bucket_name = module.aws_cloudtrail_s3_bucket_dev.bucket_name

  # Optional attributes
  create_s3_bucket = false

  tags = {
    Name  = "CloudSecure CloudTrail"
    Owner = "Engineering"
  }

  # CloudTrail validates the bucket policy at creation time, and referencing the
  # bucket name alone does not order the trail after the policy.
  depends_on = [module.aws_cloudtrail_s3_bucket_dev]
}
