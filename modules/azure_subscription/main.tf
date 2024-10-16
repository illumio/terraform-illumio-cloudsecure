# Local Variables
locals {
  subscription_scope = "/subscriptions"
  reader_role        = "Reader"
}

data "azuread_client_config" "current" {}

# Azure AD Application
resource "azuread_application" "illumio_app" {
  display_name = var.application_name
  owners       = [data.azuread_client_config.current.object_id]
  tags         = var.tags
}

# Service Principal for the Application
resource "azuread_service_principal" "illumio_sp" {
  client_id = azuread_application.illumio_app.client_id
  tags      = var.tags
}

resource "time_rotating" "example" {
  rotation_days = var.secret_expiration_days
}

# Application Password
resource "azuread_application_password" "illumio_secret" {
  application_id = azuread_application.illumio_app.id
  display_name   = var.application_secret_name
  rotate_when_changed = {
    rotation = time_rotating.example.id
  }
}

# Assigning Role for Subscription/Tenant Scope
resource "azurerm_role_assignment" "illumio_reader_role" {
  principal_id         = azuread_service_principal.illumio_sp.object_id
  role_definition_name = local.reader_role
  scope                = "${local.subscription_scope}/${var.subscription_id}"

  depends_on = [
    azuread_service_principal.illumio_sp
  ]
}

# Role Definitions for Firewall
resource "azurerm_role_definition" "illumio_fw_role" {
  name        = var.firewall_role_name
  description = "Illumio Firewall Administrator role"

  permissions {
    actions = concat(
      [
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
        "Microsoft.Network/ipGroups/read"
      ],
      var.mode == "ReadWrite" ? [
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
      ] : []
    )
  }

  assignable_scopes = ["${local.subscription_scope}/${var.subscription_id}"]
  scope             = "${local.subscription_scope}/${var.subscription_id}"
}

# Assigning Role for Firewall
resource "azurerm_role_assignment" "illumio_fw_assignment" {
  principal_id       = azuread_service_principal.illumio_sp.object_id
  role_definition_id = azurerm_role_definition.illumio_fw_role.role_definition_resource_id
  scope              = "${local.subscription_scope}/${var.subscription_id}"
}

# Role Definitions for NSG
resource "azurerm_role_definition" "illumio_nsg_role" {
  name        = var.nsg_role_name
  description = "Illumio Network Security Administrator role"

  permissions {
    actions = concat(
      [
        "Microsoft.Network/networkInterfaces/effectiveNetworkSecurityGroups/action",
        "Microsoft.Network/networkSecurityGroups/read",
        "Microsoft.Network/networkSecurityGroups/defaultSecurityRules/read",
        "Microsoft.Network/networksecuritygroups/providers/Microsoft.Insights/diagnosticSettings/read",
        "Microsoft.Network/networksecuritygroups/providers/Microsoft.Insights/logDefinitions/read",
        "Microsoft.Network/networkWatchers/securityGroupView/action"
      ],
      var.mode == "ReadWrite" ? [
        "Microsoft.Network/networkSecurityGroups/write",
        "Microsoft.Network/networkSecurityGroups/delete",
        "Microsoft.Network/networkSecurityGroups/securityRules/write",
        "Microsoft.Network/networkSecurityGroups/securityRules/delete",
        "Microsoft.Network/networksecuritygroups/providers/Microsoft.Insights/diagnosticSettings/write"
      ] : []
    )
  }

  assignable_scopes = ["${local.subscription_scope}/${var.subscription_id}"]
  scope             = "${local.subscription_scope}/${var.subscription_id}"
}

# Assigning Role for NSG
resource "azurerm_role_assignment" "illumio_nsg_assignment" {
  principal_id       = azuread_service_principal.illumio_sp.object_id
  role_definition_id = azurerm_role_definition.illumio_nsg_role.role_definition_resource_id
  scope              = "${local.subscription_scope}/${var.subscription_id}"
}


resource "illumio-cloudsecure_azure_subscription" "subscription" {
  client_id       = azuread_application.illumio_app.client_id
  client_secret   = base64encode(azuread_application_password.illumio_secret.value)
  name            = var.name
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  mode            = var.mode

  depends_on = [
    azurerm_role_assignment.illumio_reader_role,
    azurerm_role_assignment.illumio_fw_assignment,
    azurerm_role_assignment.illumio_nsg_assignment
  ]
}