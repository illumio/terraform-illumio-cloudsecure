<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 1.2.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 3.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | >= 1.2.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.12 |

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
| [time_rotating.secret_rotation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_secret_expiration_days"></a> [azure\_secret\_expiration\_days](#input\_azure\_secret\_expiration\_days) | The number of days the Azure service principal secret remains valid before requiring renewal. | `number` | `365` | no |
| <a name="input_iam_name_prefix"></a> [iam\_name\_prefix](#input\_iam\_name\_prefix) | The prefix given to all Azure resource names. | `string` | `"IllumioCloudIntegration"` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | The account's access mode, must be "ReadWrite" (default) or "Read". | `string` | `"ReadWrite"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of this subscription in CloudSecure. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The optional tags added to every configured Azure resource. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_secret_expiration_days"></a> [azure\_secret\_expiration\_days](#output\_azure\_secret\_expiration\_days) | The number of days the Azure service principal secret remains valid before requiring renewal. |
| <a name="output_iam_name_prefix"></a> [iam\_name\_prefix](#output\_iam\_name\_prefix) | The prefix given to all Azure resource names. |
| <a name="output_mode"></a> [mode](#output\_mode) | The account's access mode, must be "ReadWrite" (default) or "Read". |
| <a name="output_service_principal_client_id"></a> [service\_principal\_client\_id](#output\_service\_principal\_client\_id) | The ID of the service principal created for Illumio CloudSecure. |
<!-- END_TF_DOCS -->