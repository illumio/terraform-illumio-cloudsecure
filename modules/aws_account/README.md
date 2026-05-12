<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 1.0.11 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | >= 1.0.11 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.protection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [illumio-cloudsecure_aws_account.account](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/aws_account) | resource |
| [random_password.role_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Optional. The 12-digit AWS Account ID. When set, the module skips the aws\_caller\_identity data source lookup. Recommended for at-scale for\_each patterns over many accounts. | `string` | `null` | no |
| <a name="input_iam_name_prefix"></a> [iam\_name\_prefix](#input\_iam\_name\_prefix) | The prefix given to all AWS IAM resource names. | `string` | `"IllumioCloudIntegration"` | no |
| <a name="input_illumio_cloudsecure_account_id"></a> [illumio\_cloudsecure\_account\_id](#input\_illumio\_cloudsecure\_account\_id) | The CloudSecure AWS account ID that is given the IAM role. | `string` | `"712001342241"` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | The account's access mode, must be "ReadWrite" (default) or "Read". | `string` | `"ReadWrite"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of this account in CloudSecure. | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | Optional. The AWS Organizations organization ID (e.g., o-xxxxxxxxxx). When set, the module skips the aws\_organizations\_organization data source lookup, which is useful when the calling identity lacks organizations:DescribeOrganization or when running at scale. | `string` | `null` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | Optional. The ARN of a pre-existing IAM role to use instead of creating a new one. When set, the module skips creating the IAM role, its inline read/protection policies, the SecurityAudit attachment, and the random external ID. The supplied role must already trust the CloudSecure account via sts:AssumeRole with the supplied role\_external\_id and must carry the equivalent read (and, when mode = "ReadWrite", protection) permissions. role\_external\_id must also be set. | `string` | `null` | no |
| <a name="input_role_external_id"></a> [role\_external\_id](#input\_role\_external\_id) | Optional. The sts:ExternalId expected by the pre-existing IAM role identified by role\_arn. Required when role\_arn is set. Rotation of this value is the caller's responsibility. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The optional tags added to every configured AWS resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | The ID (or ARN, when role\_arn is supplied) of the IAM role granted to the CloudSecure account. |
<!-- END_TF_DOCS -->