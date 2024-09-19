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
| <a name="input_create_operator_namespace"></a> [create\_operator\_namespace](#input\_create\_operator\_namespace) | If true, creates the k8s namespace where cloud-operator is to be deployed if it does not exist. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the CloudSecure onboarding credential used to onboard the k8s cluster. | `string` | `""` | no |
| <a name="input_illumio_region"></a> [illumio\_region](#input\_illumio\_region) | Illumio Region where the k8s cluster can be onboarded using this credential. An Illumio Region is a designated cloud region where the CloudSecure k8s operators in onboarded k8s clusters connect after onboarding. Choose the Illumio Region nearest to each cluster to maximize performance and security. Must be one of: `aws-ap-southeast-2`, `aws-eu-west-2`, `aws-us-west-2`. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the cloud-secure deployment in the k8s cluster and of the CloudSecure onboarding credential used to onboard the k8s cluster. | `string` | n/a | yes |
| <a name="input_operator_namespace"></a> [operator\_namespace](#input\_operator\_namespace) | The k8s namespace where cloud-operator is to be deployed into. | `string` | `"illumio-cloud"` | no |
| <a name="input_operator_version"></a> [operator\_version](#input\_operator\_version) | The version of cloud-operator to be deployed into the k8s cluster. | `string` | `"v0.0.3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The client\_id that was used to onboard the k8s cluster, and may be used to onboard other clusters. |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | The client\_secret that was used to onboard the k8s cluster, and may be used to onboard other clusters. |
<!-- END_TF_DOCS -->
