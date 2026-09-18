provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_account" {
  source  = "illumio/cloudsecure/illumio//modules/aws_account"
  version = "1.7.0"
  name    = "Test Account"
}

module "aws_flow_logs_s3_bucket_source" {
  source  = "illumio/cloudsecure/illumio//modules/aws_flow_logs_s3_bucket_source"
  version = "1.7.0"

  # Grant the onboarded account's role read access to the registered buckets.
  role_id = module.aws_account.role_id

  # Register existing customer buckets by name and optional prefix. No bucket is
  # created: these already receive VPC flow logs (create_bucket defaults to false).
  buckets = [
    { bucket_name = "flows-bucket-1" },
    { bucket_name = "flows-bucket-2", path_prefix = "custom-path/first" },
    { bucket_name = "flows-bucket-3", path_prefix = "custom-path/second" },
  ]
}
