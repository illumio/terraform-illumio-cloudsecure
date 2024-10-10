provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_account_dev" {
  source = "github.com/illumio/terraform-illumio-cloudsecure//modules/aws_account?ref=v1.2.4"
  name   = "Test Account"
  tags   = {
    Name  = "CloudSecure Account Policy"
    Owner = "Engineering"
  }
}