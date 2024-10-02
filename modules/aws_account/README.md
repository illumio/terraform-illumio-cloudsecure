<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | ~> 1.0.11 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | ~> 1.0.11 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.protection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [illumio-cloudsecure_aws_account.account](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/aws_account) | resource |
| [random_uuid.role_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_name_prefix"></a> [iam\_name\_prefix](#input\_iam\_name\_prefix) | The prefix given to all AWS IAM resource names. | `string` | `"IllumioCloudIntegration"` | no |
| <a name="input_illumio_cloudsecure_account_id"></a> [illumio\_cloudsecure\_account\_id](#input\_illumio\_cloudsecure\_account\_id) | The CloudSecure AWS account ID that is given the IAM role. | `string` | `"712001342241"` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | The account's access mode, must be "ReadWrite" (default) or "Read". | `string` | `"ReadWrite"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of this account in CloudSecure. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The optional tags added to every configured AWS resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The ARN of the IAM role granted to the CloudSecure account. |
<!-- END_TF_DOCS -->