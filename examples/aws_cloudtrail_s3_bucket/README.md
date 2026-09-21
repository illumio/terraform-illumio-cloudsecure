<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.40.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_cloudtrail_dev"></a> [aws\_cloudtrail\_dev](#module\_aws\_cloudtrail\_dev) | illumio/cloudsecure/illumio//modules/aws_cloudtrail | 1.7.0 |
| <a name="module_aws_cloudtrail_s3_bucket_dev"></a> [aws\_cloudtrail\_s3\_bucket\_dev](#module\_aws\_cloudtrail\_s3\_bucket\_dev) | illumio/cloudsecure/illumio//modules/aws_cloudtrail_s3_bucket | 1.7.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_illumio_cloudsecure_client_id"></a> [illumio\_cloudsecure\_client\_id](#input\_illumio\_cloudsecure\_client\_id) | The OAuth 2 client identifier used to authenticate against the CloudSecure Config API. | `string` | n/a | yes |
| <a name="input_illumio_cloudsecure_client_secret"></a> [illumio\_cloudsecure\_client\_secret](#input\_illumio\_cloudsecure\_client\_secret) | The OAuth 2 client secret used to authenticate against the CloudSecure Config API. | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The globally unique name of the S3 bucket created by the example in the log bucket Region to receive the CloudTrail log files. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
