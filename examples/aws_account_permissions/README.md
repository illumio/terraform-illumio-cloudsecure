<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                                                    | Version   |
|---------------------------------------------------------------------------------------------------------|-----------|
| <a name="requirement_aws"></a> [helm](#requirement\_helm)                                               | ~> 3.0    |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | ~> 1.0.10 |

## Providers

No providers.

## Modules

| Name                                                                                             | Source                                | Version |
|--------------------------------------------------------------------------------------------------|---------------------------------------|---------|
| <a name="module_aws_account_permissions"></a> [aws\_account\_permissions](#module\_k8s\_cluster) | ../../modules/aws_account_permissions | n/a |

## Resources

No resources.

## Inputs

| Name                                                                                                                                        | Description                                                                            | Type | Default                        | Required |
|---------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|------|--------------------------------|:--------:|
| <a name="input_illumio_cloudsecure_client_id"></a> [illumio\_cloudsecure\_client\_id](#input\_illumio\_cloudsecure\_client\_id)             | The OAuth 2 client identifier used to authenticate against the CloudSecure Config API. | `string` | n/a                            |   yes    |
| <a name="input_illumio_cloudsecure_client_secret"></a> [illumio\_cloudsecure\_client\_secret](#input\_illumio\_cloudsecure\_client\_secret) | The OAuth 2 client secret used to authenticate against the CloudSecure Config API.     | `string` | n/a                            |   yes    |
| <a name="input_name"></a> [name](#input\_name)                                                                                              | Display name for the AWS account.                                                      | `string` | `"us"`                         |    no    |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name)                                                               | AWS role name for Illumio permissions                                                  | `string` | `"IllumioCloudIntegrationRole"` |    no    |
| <a name="input_access_mode"></a> [access\_mode](#input\_access\_mode)                                                                       | Access mode, must be "ReadWrite" or "Read".                                            | `string` | `"ReadWrite"`                  |    no    |
| <a name="input_flow_logs_bucket_arns"></a> [flow\_logs\_bucket\_arns](#input\_flow\_logs\_bucket\_arns)                                     | List of flow logs buckets arns including paths                                         | `string` | []                             |    no    |





## Outputs

| Name                                                                                     | Description |
|------------------------------------------------------------------------------------------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn)                           | Role ARN    |
| <a name="output_external_id"></a> [external\_id](#output\_external\_id)                  | External ID |
<!-- END_TF_DOCS -->