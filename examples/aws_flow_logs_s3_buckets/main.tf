provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_account_dev" {
  source  = "illumio/cloudsecure/illumio//modules/aws_account"
  version = "1.6.4"
  name    = "Test Account"
  tags    = {
    Name  = "CloudSecure Account Policy"
    Owner = "Engineering"
  }
}

module "aws_flow_logs_s3_buckets" {
  source         = "illumio/cloudsecure/illumio//modules/aws_flow_logs_s3_buckets"
  version        = "1.6.4"
  role_id        = aws_account_dev.role_id
  s3_bucket_arns = [
    "arn:aws:s3:::flows-bucket-1",
    "arn:aws:s3:::flows-bucket-2",
    "arn:aws:s3:::flows-bucket-3",
    "arn:aws:s3:::flows-bucket-4/custom-path/first",
    "arn:aws:s3:::flows-bucket-5/custom-path/second"
  ]
}
