provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_account_dev" {
  source = "github.com/illumio/terraform-illumio-cloudsecure//modules/aws_account?ref=v1.3.0"
  name   = "Test Account"
  tags   = {
    Name  = "CloudSecure Account Policy"
    Owner = "Engineering"
  }
}

module "aws_flow_logs_s3_buckets" {
  source         = "github.com/illumio/terraform-illumio-cloudsecure//modules/aws_flow_logs_s3_buckets?ref=v1.3.0"
  role_id        = aws_account_dev.role_id
  s3_bucket_arns = [
    "arn:aws:s3:::vpc1",
    "arn:aws:s3:::vpc2"
  ]
}
