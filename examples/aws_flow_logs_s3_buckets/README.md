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
| <a name="module_aws_account_dev"></a> [aws\_account\_dev](#module\_aws\_account\_dev) | illumio/cloudsecure/illumio//modules/aws_account | 1.5.3 |
| <a name="module_aws_flow_logs_s3_buckets"></a> [aws\_flow\_logs\_s3\_buckets](#module\_aws\_flow\_logs\_s3\_buckets) | illumio/cloudsecure/illumio//modules/aws_flow_logs_s3_buckets | 1.5.3 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_illumio_cloudsecure_client_id"></a> [illumio\_cloudsecure\_client\_id](#input\_illumio\_cloudsecure\_client\_id) | The OAuth 2 client identifier used to authenticate against the CloudSecure Config API. | `string` | n/a | yes |
| <a name="input_illumio_cloudsecure_client_secret"></a> [illumio\_cloudsecure\_client\_secret](#input\_illumio\_cloudsecure\_client\_secret) | The OAuth 2 client secret used to authenticate against the CloudSecure Config API. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->