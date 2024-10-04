<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | ~> 1.0.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | ~> 1.0.11 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy.s3_bucket_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [illumio-cloudsecure_aws_flow_logs_s3_bucket.bucket_example](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/aws_flow_logs_s3_bucket) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_name_prefix"></a> [iam\_name\_prefix](#input\_iam\_name\_prefix) | The prefix given to all AWS IAM resource names. | `string` | `"IllumioCloudIntegration"` | no |
| <a name="input_role_id"></a> [role\_id](#input\_role\_id) | The ID of the IAM role granted to the CloudSecure account. | `string` | n/a | yes |
| <a name="input_s3_bucket_arns"></a> [s3\_bucket\_arns](#input\_s3\_bucket\_arns) | The set of ARNs of AWS S3 buckets containing flow logs. | `set(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->