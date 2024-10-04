provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_flows_dev" {
  source        = "github.com/illumio/terraform-illumio-cloudsecure//modules/aws_flows?ref=v1.2.0"
  role_arn      = var.illumio_cloudsecure_role_arn
  flow_logs_bucket_arns = var.flow_logs_bucket_arns
}