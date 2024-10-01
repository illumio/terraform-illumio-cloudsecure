<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~>2.15.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | ~> 1.0.11 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_k8s_cluster"></a> [k8s\_cluster](#module\_k8s\_cluster) | ../../modules/k8s_cluster | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The description of the onboarding credential. | `string` | `"Credential to onboard dev clusters in aws-us-west-2 illumio region"` | no |
| <a name="input_illumio_cloudsecure_client_id"></a> [illumio\_cloudsecure\_client\_id](#input\_illumio\_cloudsecure\_client\_id) | The OAuth 2 client identifier used to authenticate against the CloudSecure Config API. | `string` | n/a | yes |
| <a name="input_illumio_cloudsecure_client_secret"></a> [illumio\_cloudsecure\_client\_secret](#input\_illumio\_cloudsecure\_client\_secret) | The OAuth 2 client secret used to authenticate against the CloudSecure Config API. | `string` | n/a | yes |
| <a name="input_illumio_region"></a> [illumio\_region](#input\_illumio\_region) | The Illumio region where the Kubernetes cluster is located. | `string` | `"aws-us-west-2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the onboarding credential and Helm release. | `string` | `"example-release"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The client\_id to use to onboard k8s clusters. |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | The client\_secret to use to onboard k8s clusters. |
<!-- END_TF_DOCS -->