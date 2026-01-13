<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.15 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 1.7.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_k8s_cluster_dev"></a> [k8s\_cluster\_dev](#module\_k8s\_cluster\_dev) | illumio/cloudsecure/illumio//modules/k8s_cluster | 1.6.2 |

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