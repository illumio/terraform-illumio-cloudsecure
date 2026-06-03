provider "azurerm" {
  features {}
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
}

provider "azuread" {
  client_id     = var.azure_client_id
  client_secret = var.azure_client_secret
  tenant_id     = var.azure_tenant_id
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "azure_subscription_dev" {
  source  = "illumio/cloudsecure/illumio//modules/azure_subscription"
  version = "1.6.8"
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
  version                         = "1.6.8"
  name                            = "Test Azure Subscription (existing service principal)"
  mode                            = "ReadWrite"
  service_principal_client_id     = var.illumio_service_principal_client_id
  service_principal_client_secret = var.illumio_service_principal_client_secret

  tags = [
    "Environment=Dev",
    "Owner=John Doe"
  ]
}

# At-scale pattern: BYO service principal, RBAC managed at management group level,
# and explicit subscription/tenant IDs to avoid one ARM data-source call per subscription.
# This is the recommended pattern when onboarding hundreds of subscriptions via for_each.
module "azure_subscription_at_scale" {
  source  = "illumio/cloudsecure/illumio//modules/azure_subscription"
  version = "1.6.8"
  name    = "Test Azure Subscription (at-scale pattern)"
  mode    = "Read"

  service_principal_client_id     = var.illumio_service_principal_client_id
  service_principal_client_secret = var.illumio_service_principal_client_secret

  create_azure_rbac_assignments = false
  subscription_id               = var.azure_subscription_id
  tenant_id                     = var.azure_tenant_id
}