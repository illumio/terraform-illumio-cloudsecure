provider "azurerm" {
  features {}
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "azure_flow_logs_storage_account_source" {
  source  = "illumio/cloudsecure/illumio//modules/azure_flow_logs_storage_account_source"
  version = "1.7.0"

  subscription_id = var.azure_subscription_id

  # Register existing customer storage accounts by name and optional container
  # and prefix. These already receive flow logs; nothing is created.
  storage_accounts = [
    {
      storage_account_name = "flowsstorage1"
    },
    {
      storage_account_name = "flowsstorage2"
      container_name       = "insights-logs-networksecuritygroupflowevent"
      path_prefix          = "custom-path/first"
    },
  ]

  # To let the module grant CloudSecure blob read access, set
  # service_principal_object_id and add resource_group_name to each account above:
  #
  # service_principal_object_id = "00000000-0000-0000-0000-000000000000"
}
