locals {
  subscription_id = var.subscription_id != null ? var.subscription_id : data.azurerm_subscription.current[0].subscription_id

  # A stable, unique key per registered source. subscription_id is constant for
  # the module call, so (storage_account_name, container_name, path_prefix) is
  # the source identity.
  accounts_by_key = {
    for a in var.storage_accounts :
    "${a.storage_account_name}${a.container_name == null ? "" : "::${a.container_name}"}${a.path_prefix == null ? "" : "::${a.path_prefix}"}" => a
  }

  grant_read_access = var.service_principal_object_id != null

  # Blob read access is granted per storage account, so dedupe entries that only
  # differ by container_name or path_prefix.
  grant_accounts = local.grant_read_access ? {
    for a in var.storage_accounts :
    "${a.storage_account_name}::${a.resource_group_name}" => a
  } : {}
}

data "azurerm_subscription" "current" {
  count = var.subscription_id == null ? 1 : 0
}

# Optionally grant the CloudSecure service principal blob read access.
data "azurerm_storage_account" "this" {
  for_each            = local.grant_accounts
  name                = each.value.storage_account_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_role_assignment" "blob_reader" {
  for_each             = local.grant_accounts
  scope                = data.azurerm_storage_account.this[each.key].id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.service_principal_object_id
}

# Register each existing storage account with CloudSecure by name and (optional)
# container name and path prefix.
resource "illumio-cloudsecure_azure_flow_logs_storage_account_source" "this" {
  for_each             = local.accounts_by_key
  subscription_id      = local.subscription_id
  storage_account_name = each.value.storage_account_name
  container_name       = each.value.container_name
  path_prefix          = each.value.path_prefix

  depends_on = [azurerm_role_assignment.blob_reader]
}
