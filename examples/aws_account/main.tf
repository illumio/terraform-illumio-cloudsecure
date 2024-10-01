provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_account_permissions" {
  source        = "github.com/illumio/terraform-illumio-cloudsecure//modules/aws_account_permissions?ref=v1.0.1"
  iam_role_name = var.iam_role_name
  mode          = var.mode
  name          = var.name
}