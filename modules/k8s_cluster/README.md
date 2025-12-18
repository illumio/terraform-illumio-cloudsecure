<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.15 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 1.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.15 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | >= 1.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.helm_cloud_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [illumio-cloudsecure_k8s_cluster.this](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/k8s_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_operator_namespace"></a> [create\_operator\_namespace](#input\_create\_operator\_namespace) | If true, creates the k8s namespace where cloud-operator is to be deployed if it does not exist. | `bool` | `true` | no |
| <a name="input_enable_falco"></a> [enable\_falco](#input\_enable\_falco) | If true, deploys the Falco agent along with cloud-operator to collect network flows. | `bool` | `false` | no |
| <a name="input_https_proxy"></a> [https\_proxy](#input\_https\_proxy) | The URL of the HTTPS proxy to be used by cloud-operator to connect to Illumio CloudSecure. If not set, no proxy will be used. | `string` | `null` | no |
| <a name="input_illumio_region"></a> [illumio\_region](#input\_illumio\_region) | Illumio Region where the k8s cluster will be onboarded. An Illumio Region is a designated cloud region where the CloudSecure cloud-operator deployed in the k8s cluster connects after onboarding. Choose the Illumio Region nearest to the k8s cluster to maximize performance and security. Must be one of: `aws-ap-southeast-2`, `aws-eu-west-2`, `aws-me-central-1`, `aws-us-west-1`, `aws-us-west-2`, `azure-australia-east`, `azure-germany-west-central`, `azure-japan-east`, `azure-north-europe`, `azure-uae-north`, `azure-us-east`, `azure-us-west-2`, `azure-us-west-3`. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the cloud-secure deployment in the k8s cluster. | `string` | n/a | yes |
| <a name="input_operator_namespace"></a> [operator\_namespace](#input\_operator\_namespace) | The k8s namespace where cloud-operator is to be deployed into. | `string` | `"illumio-cloud"` | no |
| <a name="input_operator_version"></a> [operator\_version](#input\_operator\_version) | The version of cloud-operator to be deployed into the k8s cluster. | `string` | `"v1.3.6"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The CloudSecure identifier of the onboarded k8s cluster. |
<!-- END_TF_DOCS -->