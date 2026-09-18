<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | >= 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.flow_logs_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [illumio-cloudsecure_aws_flow_logs_s3_bucket_source.this](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/aws_flow_logs_s3_bucket_source) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The 12-digit AWS Account ID that owns the S3 buckets. When null, the module resolves it from the aws\_caller\_identity data source. | `string` | `null` | no |
| <a name="input_buckets"></a> [buckets](#input\_buckets) | The set of existing S3 buckets receiving VPC flow logs to register with CloudSecure by name and (optional) path prefix. Customers usually already have flow logs delivered to these buckets; no bucket is created unless create\_bucket is true. | <pre>set(object({<br>    bucket_name = string<br>    path_prefix = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | When true, create each S3 bucket and attach a bucket policy that allows VPC flow log delivery. Defaults to false because customers usually already have a bucket receiving flow logs. Configuring the VPC flow log delivery itself remains the caller's responsibility. | `bool` | `false` | no |
| <a name="input_iam_name_prefix"></a> [iam\_name\_prefix](#input\_iam\_name\_prefix) | The prefix given to all AWS IAM resource names created by this module. | `string` | `"IllumioCloudIntegration"` | no |
| <a name="input_role_id"></a> [role\_id](#input\_role\_id) | The ID of the IAM role granted to the CloudSecure account (see the aws\_account module's role\_id output). When set, the module attaches an inline policy granting read access to the registered buckets. When null, granting CloudSecure read access to the buckets is the caller's responsibility. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The optional tags added to every S3 bucket created when create\_bucket is true. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_names"></a> [bucket\_names](#output\_bucket\_names) | The set of registered S3 bucket names. |
| <a name="output_source_ids"></a> [source\_ids](#output\_source\_ids) | Map of bucket key ("<bucket\_name>" or "<bucket\_name>::<path\_prefix>") to the CloudSecure flow logs S3 bucket source ID. |
<!-- END_TF_DOCS -->
