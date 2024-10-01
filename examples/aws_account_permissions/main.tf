terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = "~> 1.0.11"
    }
  }
}
provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_account_permissions" {
  source        = "github.com/illumio/terraform-illumio-cloudsecure//modules/aws_account_permissions?ref=v1.0.0"
  iam_role_name = var.iam_role_name
  access_mode   = var.access_mode
}