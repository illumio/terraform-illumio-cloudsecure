data "azuread_client_config" "current" {}

locals {
  use_existing_service_principal = var.service_principal_client_id != null
  client_id                      = local.use_existing_service_principal ? var.service_principal_client_id : azuread_application.illumio_app[0].client_id
  client_secret                  = local.use_existing_service_principal ? var.service_principal_client_secret : azuread_application_password.illumio_secret[0].value
  service_principal_object_id    = local.use_existing_service_principal ? data.azuread_service_principal.existing[0].object_id : azuread_service_principal.illumio_sp[0].object_id
  subscription_id                = var.subscription_id != null ? var.subscription_id : data.azurerm_subscription.current[0].subscription_id
  tenant_id                      = var.tenant_id != null ? var.tenant_id : data.azurerm_subscription.current[0].tenant_id
}

# Look up the pre-existing service principal when the caller supplies an app registration.
data "azuread_service_principal" "existing" {
  count     = local.use_existing_service_principal ? 1 : 0
  client_id = var.service_principal_client_id
}

# Azure AD Application
resource "azuread_application" "illumio_app" {
  count        = local.use_existing_service_principal ? 0 : 1
  display_name = "${var.iam_name_prefix}App"
  description  = "Illumio CloudSecure Azure Subscription Integration"
  owners       = [data.azuread_client_config.current.object_id]
  tags         = var.tags
}

# Service Principal for the Application
resource "azuread_service_principal" "illumio_sp" {
  count       = local.use_existing_service_principal ? 0 : 1
  client_id   = azuread_application.illumio_app[0].client_id
  description = "Service Principal for Illumio CloudSecure Azure Subscription Integration"
  owners      = [data.azuread_client_config.current.object_id]
  tags        = var.tags
}

resource "time_rotating" "secret_rotation" {
  count         = local.use_existing_service_principal ? 0 : 1
  rotation_days = var.azure_secret_expiration_days
}

# Application Password
resource "azuread_application_password" "illumio_secret" {
  count          = local.use_existing_service_principal ? 0 : 1
  application_id = azuread_application.illumio_app[0].id
  display_name   = "${var.iam_name_prefix}Secret"
  rotate_when_changed = {
    rotation = time_rotating.secret_rotation[0].id
  }
}

# Assigning Reader Role for Subscription Scope
resource "azurerm_role_assignment" "illumio_reader_role" {
  count                = var.create_azure_rbac_assignments ? 1 : 0
  principal_id         = local.service_principal_object_id
  description          = "Illumio Reader role assignment"
  role_definition_name = "Reader"
  scope                = "/subscriptions/${local.subscription_id}"
}

# Role Definitions for Firewall
resource "azurerm_role_definition" "illumio_fw_role" {
  count       = (var.create_azure_rbac_assignments && var.mode == "ReadWrite") ? 1 : 0
  name        = "${var.iam_name_prefix}FirewallRole"
  description = "Illumio Firewall Administrator role"

  permissions {
    actions = [
      "Microsoft.Network/azurefirewalls/read",
      "Microsoft.Network/azurefirewalls/learnedIPPrefixes/action",
      "Microsoft.Network/azureFirewalls/applicationRuleCollections/read",
      "Microsoft.Network/azureFirewalls/natRuleCollections/read",
      "Microsoft.Network/azureFirewalls/networkRuleCollections/read",
      "Microsoft.Network/azureFirewallFqdnTags/read",
      "Microsoft.Network/azurefirewalls/providers/Microsoft.Insights/logDefinitions/read",
      "Microsoft.Network/azurefirewalls/providers/Microsoft.Insights/metricDefinitions/read",
      "Microsoft.Network/firewallPolicies/read",
      "Microsoft.Network/firewallPolicies/ruleCollectionGroups/read",
      "Microsoft.Network/firewallPolicies/ruleGroups/read",
      "Microsoft.Network/ipGroups/read",
      "Microsoft.Network/azureFirewalls/applicationRuleCollections/write",
      "Microsoft.Network/azureFirewalls/applicationRuleCollections/delete",
      "Microsoft.Network/azureFirewalls/natRuleCollections/write",
      "Microsoft.Network/azureFirewalls/natRuleCollections/delete",
      "Microsoft.Network/azureFirewalls/networkRuleCollections/write",
      "Microsoft.Network/azureFirewalls/networkRuleCollections/delete",
      "Microsoft.Network/firewallPolicies/write",
      "Microsoft.Network/firewallPolicies/join/action",
      "Microsoft.Network/firewallPolicies/certificates/action",
      "Microsoft.Network/firewallPolicies/delete",
      "Microsoft.Network/firewallPolicies/ruleCollectionGroups/write",
      "Microsoft.Network/firewallPolicies/ruleCollectionGroups/delete",
      "Microsoft.Network/firewallPolicies/ruleGroups/write",
      "Microsoft.Network/firewallPolicies/ruleGroups/delete",
      "Microsoft.Network/ipGroups/write",
      "Microsoft.Network/ipGroups/validate/action",
      "Microsoft.Network/ipGroups/updateReferences/action",
      "Microsoft.Network/ipGroups/join/action",
      "Microsoft.Network/ipGroups/delete"
    ]
  }

  assignable_scopes = ["/subscriptions/${local.subscription_id}"]
  scope             = "/subscriptions/${local.subscription_id}"
}

# Assigning Role for Firewall
resource "azurerm_role_assignment" "illumio_fw_assignment" {
  count              = (var.create_azure_rbac_assignments && var.mode == "ReadWrite") ? 1 : 0
  principal_id       = local.service_principal_object_id
  description        = "Illumio Firewall role assignment"
  role_definition_id = azurerm_role_definition.illumio_fw_role[0].role_definition_resource_id
  scope              = "/subscriptions/${local.subscription_id}"
}

# Role Definitions for NSG
resource "azurerm_role_definition" "illumio_nsg_role" {
  count       = (var.create_azure_rbac_assignments && var.mode == "ReadWrite") ? 1 : 0
  name        = "${var.iam_name_prefix}NSGRole"
  description = "Illumio Network Security Administrator role"

  permissions {
    actions = [
      "Microsoft.Network/networkInterfaces/effectiveNetworkSecurityGroups/action",
      "Microsoft.Network/networkSecurityGroups/read",
      "Microsoft.Network/networkSecurityGroups/defaultSecurityRules/read",
      "Microsoft.Network/networksecuritygroups/providers/Microsoft.Insights/diagnosticSettings/read",
      "Microsoft.Network/networksecuritygroups/providers/Microsoft.Insights/logDefinitions/read",
      "Microsoft.Network/networkWatchers/securityGroupView/action",
      "Microsoft.Network/networkSecurityGroups/write",
      "Microsoft.Network/networkSecurityGroups/delete",
      "Microsoft.Network/networkSecurityGroups/securityRules/write",
      "Microsoft.Network/networkSecurityGroups/securityRules/delete",
      "Microsoft.Network/networksecuritygroups/providers/Microsoft.Insights/diagnosticSettings/write"
    ]
  }

  assignable_scopes = ["/subscriptions/${local.subscription_id}"]
  scope             = "/subscriptions/${local.subscription_id}"
}

# Assigning Role for NSG
resource "azurerm_role_assignment" "illumio_nsg_assignment" {
  count              = (var.create_azure_rbac_assignments && var.mode == "ReadWrite") ? 1 : 0
  principal_id       = local.service_principal_object_id
  description        = "Illumio NSG role assignment"
  role_definition_id = azurerm_role_definition.illumio_nsg_role[0].role_definition_resource_id
  scope              = "/subscriptions/${local.subscription_id}"
}


data "azurerm_subscription" "current" {
  count = var.subscription_id == null ? 1 : 0
}

resource "illumio-cloudsecure_azure_subscription" "subscription" {
  client_id       = local.client_id
  client_secret   = base64encode(local.client_secret)
  name            = var.name
  subscription_id = local.subscription_id
  tenant_id       = local.tenant_id
  mode            = var.mode

  depends_on = [
    azurerm_role_assignment.illumio_reader_role,
    azurerm_role_assignment.illumio_fw_assignment,
    azurerm_role_assignment.illumio_nsg_assignment
  ]
}
