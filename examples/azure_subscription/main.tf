provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_account_dev" {
  source = "github.com/illumio/terraform-illumio-cloudsecure//modules/azure_subscription?ref=v1.3.0"
  name   = "Test Azure Subscription"
  mode                   = "ReadWrite"
  secret_expiration_days = 365
  subscription_id        = "1681e851-ba2d-410b-a66a-9511887e1c1a" # Azure Subscription ID
  tenant_id              = "b563cc25-a007-4837-981a-cbe2017228a4" # Azure Tenant ID

  tags = [
    "Environment=Dev",
    "Owner=John Doe"
  ]
}