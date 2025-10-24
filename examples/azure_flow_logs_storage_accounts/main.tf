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
  source                 = "illumio/cloudsecure/illumio//modules/azure_subscription"
  version                = "1.5.4"
  name                   = "Test Azure Subscription"
  mode                   = "ReadWrite"
  secret_expiration_days = 365
  subscription_id        = "1681e851-ba2d-410b-a66a-9511887e1c1a" # Azure Subscription ID
  tenant_id              = "b563cc25-a007-4837-981a-cbe2017228a4" # Azure Tenant ID

  tags = [
    "Environment=Dev",
    "Owner=John Doe"
  ]
}

module "azure_flow_logs_storage_accounts" {
  source                      = "illumio/cloudsecure/illumio//modules/azure_flow_logs_storage_accounts"
  version                     = "1.5.4"
  service_principal_client_id = module.azure_subscription_dev.service_principal_client_id

  storage_accounts = [
    {
      name                = "welcomegsk"
      resource_group_name = "demo1"
    },
    {
      name                = "secondstorage"
      resource_group_name = "demo2"
    },
    {
      name                = "thirdstorage"
      resource_group_name = "demo3"
    }
  ]
}