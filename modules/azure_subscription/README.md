<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >=3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 1.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >=3.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | >= 1.1.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.illumio_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_password.illumio_secret](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_service_principal.illumio_sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.illumio_fw_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.illumio_nsg_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.illumio_reader_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.illumio_fw_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_role_definition.illumio_nsg_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [illumio-cloudsecure_azure_subscription.subscription](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/azure_subscription) | resource |
| [time_rotating.example](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | n/a | `string` | `"Illumio-CloudSecure-Access"` | no |
| <a name="input_application_secret_name"></a> [application\_secret\_name](#input\_application\_secret\_name) | n/a | `string` | `"Illumio-CloudSecure-Secret"` | no |
| <a name="input_firewall_role_name"></a> [firewall\_role\_name](#input\_firewall\_role\_name) | n/a | `string` | `"Illumio Firewall Administrator"` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | The account's access mode, must be "ReadWrite" (default) or "Read". | `string` | `"ReadWrite"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of this account in CloudSecure. | `string` | n/a | yes |
| <a name="input_nsg_role_name"></a> [nsg\_role\_name](#input\_nsg\_role\_name) | n/a | `string` | `"Illumio Network Security Administrator"` | no |
| <a name="input_secret_expiration_days"></a> [secret\_expiration\_days](#input\_secret\_expiration\_days) | The number of days the secret will be valid. | `number` | `365` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The subscription ID of the Azure account. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The optional tags added to every configured AWS resource. | `set(string)` | `[]` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The tenant ID of the Azure account. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->