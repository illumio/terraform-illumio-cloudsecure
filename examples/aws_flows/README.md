## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>3.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | ~> 1.0.11 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_flows_dev"></a> [aws\_flows\_dev](#module\_aws\_flows\_dev) | github.com/illumio/terraform-illumio-cloudsecure//modules/aws_flows | v1.2.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_flow_logs_bucket_arns"></a> [flow\_logs\_bucket\_arns](#input\_flow\_logs\_bucket\_arns) | List of S3 buckets having flow logs | `list(string)` | n/a | yes |
| <a name="input_illumio_cloudsecure_client_id"></a> [illumio\_cloudsecure\_client\_id](#input\_illumio\_cloudsecure\_client\_id) | The OAuth 2 client identifier used to authenticate against the CloudSecure Config API. | `string` | n/a | yes |
| <a name="input_illumio_cloudsecure_client_secret"></a> [illumio\_cloudsecure\_client\_secret](#input\_illumio\_cloudsecure\_client\_secret) | The OAuth 2 client secret used to authenticate against the CloudSecure Config API. | `string` | n/a | yes |
| <a name="input_illumio_cloudsecure_role_arn"></a> [illumio\_cloudsecure\_role\_arn](#input\_illumio\_cloudsecure\_role\_arn) | The ARN of the IAM role granted to the CloudSecure account. | `string` | n/a | yes |

## Outputs

No outputs.
