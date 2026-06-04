<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 1.0.11 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_account_at_scale"></a> [aws\_account\_at\_scale](#module\_aws\_account\_at\_scale) | illumio/cloudsecure/illumio//modules/aws_account | 1.7.0 |
| <a name="module_aws_account_dev"></a> [aws\_account\_dev](#module\_aws\_account\_dev) | illumio/cloudsecure/illumio//modules/aws_account | 1.7.0 |
| <a name="module_aws_account_existing_role"></a> [aws\_account\_existing\_role](#module\_aws\_account\_existing\_role) | illumio/cloudsecure/illumio//modules/aws_account | 1.7.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The 12-digit AWS Account ID used by the at-scale example to skip the aws\_caller\_identity data source. | `string` | n/a | yes |
| <a name="input_illumio_cloudsecure_client_id"></a> [illumio\_cloudsecure\_client\_id](#input\_illumio\_cloudsecure\_client\_id) | The OAuth 2 client identifier used to authenticate against the CloudSecure Config API. | `string` | n/a | yes |
| <a name="input_illumio_cloudsecure_client_secret"></a> [illumio\_cloudsecure\_client\_secret](#input\_illumio\_cloudsecure\_client\_secret) | The OAuth 2 client secret used to authenticate against the CloudSecure Config API. | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | The AWS Organizations organization ID (e.g., o-xxxxxxxxxx) used by the at-scale example to skip the aws\_organizations\_organization data source. | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | The ARN of a pre-existing IAM role to wire into the BYO-role example module instances. | `string` | n/a | yes |
| <a name="input_role_external_id"></a> [role\_external\_id](#input\_role\_external\_id) | The sts:ExternalId expected by the pre-existing IAM role referenced by role\_arn. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->