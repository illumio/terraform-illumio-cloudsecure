provider "azurerm" {
  features {}
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
}

provider "azuread" {
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "azure_subscription_dev" {
  source  = "illumio/cloudsecure/illumio//modules/azure_subscription"
  version = "1.6.7"
  name    = "Test Azure Subscription"

  # Optional attributes
  azure_secret_expiration_days = 365
  iam_name_prefix              = "IllumioCloudIntegration"
  mode                         = "ReadWrite"

  tags = [
    "Environment=Dev",
    "Owner=John Doe"
  ]
}