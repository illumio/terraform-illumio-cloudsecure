<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | >= 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.blob_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [illumio-cloudsecure_azure_flow_logs_storage_account_source.this](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/azure_flow_logs_storage_account_source) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service_principal_object_id"></a> [service\_principal\_object\_id](#input\_service\_principal\_object\_id) | The object (principal) ID of the service principal used by CloudSecure to read the storage accounts. When set, the module assigns the built-in "Storage Blob Data Reader" role to it on each storage account. When null, granting CloudSecure read access is the caller's responsibility. | `string` | `null` | no |
| <a name="input_storage_accounts"></a> [storage\_accounts](#input\_storage\_accounts) | The set of existing storage accounts receiving flow logs to register with CloudSecure by name and (optional) container name and path prefix. resource\_group\_name is only required when service\_principal\_object\_id is set so the module can grant blob read access. | <pre>set(object({<br>    storage_account_name = string<br>    container_name       = optional(string)<br>    path_prefix          = optional(string)<br>    resource_group_name  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The ID of the Azure subscription that owns the storage accounts. When null, the module resolves it from the azurerm\_subscription data source. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_source_ids"></a> [source\_ids](#output\_source\_ids) | Map of storage account key ("<name>", optionally suffixed with "::<container>" and "::<path\_prefix>") to the CloudSecure flow logs storage account source ID. |
| <a name="output_storage_account_names"></a> [storage\_account\_names](#output\_storage\_account\_names) | The set of registered storage account names. |
<!-- END_TF_DOCS -->
