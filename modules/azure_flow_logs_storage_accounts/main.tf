data "azurerm_subscription" "current" {}

data "azurerm_storage_account" "account" {
  for_each   = {
    for index, sa in var.storage_accounts : "${sa.resource_group_name}_${sa.name}"  => sa
  }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Role Definitions for NSG
resource "azurerm_role_definition" "illumio_storage_reader" {
  name        = "${var.iam_name_prefix}SRRole"
  description = "Illumio Storage Reader role"

  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
      "Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action"
    ]
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read"
    ]
  }

  assignable_scopes = ["/subscriptions/${data.azurerm_subscription.current.subscription_id}"]
  scope             = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
}

resource "azurerm_role_assignment" "illumio_storage_reader_assignment" {
  for_each           = data.azurerm_storage_account.account
  principal_id       = var.service_principal_client_id
  description        = "Illumio NSG role assignment"
  role_definition_id = azurerm_role_definition.illumio_storage_reader.role_definition_resource_id
  scope              = each.value.id
}

resource "illumio-cloudsecure_azure_flow_logs_storage_account" "storage_accounts" {
  for_each                    = data.azurerm_storage_account.account
  subscription_id             = data.azurerm_subscription.current.subscription_id
  storage_account_resource_id = each.value.id
  depends_on = [
    azurerm_role_assignment.illumio_storage_reader_assignment
  ]
}