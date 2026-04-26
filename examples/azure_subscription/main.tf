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

# Reuse a pre-existing Azure AD application/service principal instead of
# letting the module create one. service_principal_client_id and
# service_principal_client_secret must both be set (or both null).
module "azure_subscription_existing_sp" {
  source                          = "illumio/cloudsecure/illumio//modules/azure_subscription"
  version                         = "1.6.7"
  name                            = "Test Azure Subscription (existing service principal)"
  mode                            = "ReadWrite"
  service_principal_client_id     = var.illumio_service_principal_client_id
  service_principal_client_secret = var.illumio_service_principal_client_secret

  tags = [
    "Environment=Dev",
    "Owner=John Doe"
  ]
}