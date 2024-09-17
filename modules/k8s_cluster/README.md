<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | ~> 1.0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | ~> 1.0.9 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.helm_cloud_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [illumio-cloudsecure_k8s_cluster_onboarding_credential.this](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/k8s_cluster_onboarding_credential) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the Kubernetes namespace if it does not exist. | `bool` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of the onboarding credential. | `string` | `null` | no |
| <a name="input_helm_namespace"></a> [helm\_namespace](#input\_helm\_namespace) | The Kubernetes namespace to deploy to. | `string` | n/a | yes |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | The name of the Helm release. | `string` | n/a | yes |
| <a name="input_helm_version"></a> [helm\_version](#input\_helm\_version) | The helm chart version | `string` | n/a | yes |
| <a name="input_illumio_region"></a> [illumio\_region](#input\_illumio\_region) | The Illumio region where the cluster is located. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the onboarding credential. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The client\_id to use to onboard k8s clusters. |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | The client\_secret to use to onboard k8s clusters. |
<!-- END_TF_DOCS -->