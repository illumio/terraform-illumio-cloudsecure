provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_account_dev" {
  source  = "illumio/cloudsecure/illumio//modules/aws_account"
  version = "1.6.7"
  name    = "Test Account"

  # Optional attributes
  iam_name_prefix = "IllumioCloudIntegration"
  mode            = "ReadWrite"

  tags    = {
    Name  = "CloudSecure Account Policy"
    Owner = "Engineering"
  }
}