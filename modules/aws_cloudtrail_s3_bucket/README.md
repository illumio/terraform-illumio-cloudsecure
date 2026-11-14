<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.40.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.40.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | >= 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [illumio-cloudsecure_aws_cloudtrail_s3_bucket.this](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/aws_cloudtrail_s3_bucket) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_blocked_encryption_types"></a> [blocked\_encryption\_types](#input\_blocked\_encryption\_types) | The encryption types rejected on upload into the bucket. If null, the S3 default is left in place. | `list(string)` | <pre>[<br/>  "SSE-C"<br/>]</pre> | no |
| <a name="input_bucket_key_enabled"></a> [bucket\_key\_enabled](#input\_bucket\_key\_enabled) | If true, enables S3 Bucket Keys, which cut the cost of SSE-KMS requests. | `bool` | `true` | no |
| <a name="input_cross_account_reader_actions"></a> [cross\_account\_reader\_actions](#input\_cross\_account\_reader\_actions) | The S3 actions granted to cross\_account\_reader\_arns. The default is read-only; widening it can let those principals delete or overwrite log files. | `list(string)` | <pre>[<br/>  "s3:GetObject",<br/>  "s3:ListBucket",<br/>  "s3:GetBucketLocation"<br/>]</pre> | no |
| <a name="input_cross_account_reader_arns"></a> [cross\_account\_reader\_arns](#input\_cross\_account\_reader\_arns) | The ARNs of the IAM principals from other accounts that are granted access to the bucket. If empty, no cross-account statement is added to the bucket policy. | `list(string)` | `[]` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | If true, allows Terraform to delete the bucket even when it still contains log files. | `bool` | `false` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | If true, grants write access to an organization trail instead of a trail of the bucket's account. The bucket policy then uses the ID of the organization's management account, which owns the trail even when a delegated administrator creates it, and also grants the `AWSLogs/<organization-id>/` path. Both IDs are looked up with the aws\_organizations\_organization data source, which requires the organizations:DescribeOrganization permission and returns the organization of the bucket's account, so the bucket's account must belong to the trail's organization. Must be the same as the is\_organization\_trail value of the aws\_cloudtrail module. | `bool` | `false` | no |
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | The KMS key used for the bucket's default encryption. Only applied when sse\_algorithm is "aws:kms". | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the S3 bucket to create. | `string` | n/a | yes |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | The prefix prepended to the AWSLogs/ path inside the bucket. If null, no prefix is used. | `string` | `null` | no |
| <a name="input_sse_algorithm"></a> [sse\_algorithm](#input\_sse\_algorithm) | The bucket's default server-side encryption algorithm. Must be one of: `AES256`, `aws:kms`. | `string` | `"AES256"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The optional tags added to every configured AWS resource. | `map(string)` | `{}` | no |
| <a name="input_trail_name"></a> [trail\_name](#input\_trail\_name) | The name of the CloudTrail trail allowed to write into the bucket, used in the aws:SourceArn condition of the bucket policy. The name value of the aws\_cloudtrail module must be set from the trail\_name output of this module. Unless is\_organization\_trail is true, the trail must belong to the same AWS account as the bucket. | `string` | n/a | yes |
| <a name="input_trail_region"></a> [trail\_region](#input\_trail\_region) | The home Region of the CloudTrail trail, i.e., the Region of the AWS provider used by the aws\_cloudtrail module. If null, defaults to the Region of the bucket. Only needed when the trail is created in a different Region than the bucket. | `string` | `null` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | If true, enables S3 versioning on the bucket. If false, no versioning configuration is managed at all. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The CloudSecure ID of the registered S3 bucket. |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | The name of the S3 bucket, to be used as the s3\_bucket\_name of the aws\_cloudtrail module. |
| <a name="output_s3_key_prefix"></a> [s3\_key\_prefix](#output\_s3\_key\_prefix) | The prefix prepended to the AWSLogs/ path inside the bucket, to be used as the s3\_key\_prefix of the aws\_cloudtrail module. |
| <a name="output_trail_name"></a> [trail\_name](#output\_trail\_name) | The name of the CloudTrail trail allowed to write into the bucket, to be used as the name of the aws\_cloudtrail module. |
<!-- END_TF_DOCS -->
