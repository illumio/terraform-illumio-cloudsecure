provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_account_permissions" {
  source        = "../../modules/aws_account"
  iam_role_name = var.iam_role_name
  mode          = var.mode
  name          = var.name
}