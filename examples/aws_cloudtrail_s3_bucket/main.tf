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
  blocked_encryption_types     = ["SSE-C"]
  bucket_key_enabled           = true
  cross_account_reader_actions = ["s3:GetObject", "s3:ListBucket", "s3:GetBucketLocation"]
  cross_account_reader_arns    = ["arn:aws:iam::123456789012:role/ExampleLogReaderRole"]
  force_destroy                = false
  is_organization_trail        = false
  kms_master_key_id            = "arn:aws:kms:us-west-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab" # Only applied when sse_algorithm is "aws:kms"
  s3_key_prefix                = "cloudtrail"
  sse_algorithm                = "AES256"
  trail_region                 = "us-west-2"
  versioning_enabled           = false

  tags = {
    Name  = "CloudSecure CloudTrail"
    Owner = "Engineering"
  }
}
