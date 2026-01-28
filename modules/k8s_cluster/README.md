<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 3.0.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 1.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 3.0.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | >= 1.7.2 |

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
| <a name="input_cilium_namespaces"></a> [cilium\_namespaces](#input\_cilium\_namespaces) | The namespaces in which Cilium may be deployed. | `list(string)` | <pre>[<br/>  "kube-system",<br/>  "gke-managed-dpv2-observability"<br/>]</pre> | no |
| <a name="input_create_operator_namespace"></a> [create\_operator\_namespace](#input\_create\_operator\_namespace) | If true, creates the k8s namespace where cloud-operator is to be deployed if it does not exist. | `bool` | `true` | no |
| <a name="input_enable_falco"></a> [enable\_falco](#input\_enable\_falco) | If true, deploys the Falco agent along with cloud-operator to collect network flows. | `bool` | `false` | no |
| <a name="input_https_proxy"></a> [https\_proxy](#input\_https\_proxy) | The URL of the HTTPS proxy to be used by cloud-operator to connect to Illumio CloudSecure. If not set, no proxy will be used. | `string` | `null` | no |
| <a name="input_illumio_region"></a> [illumio\_region](#input\_illumio\_region) | Illumio Region where the k8s cluster will be onboarded. An Illumio Region is a designated cloud region where the CloudSecure cloud-operator deployed in the k8s cluster connects after onboarding. Choose the Illumio Region nearest to the k8s cluster to maximize performance and security. Must be one of: `aws-ap-southeast-2`, `aws-eu-west-2`, `aws-me-central-1`, `aws-us-west-1`, `aws-us-west-2`, `azure-australia-east`, `azure-germany-west-central`, `azure-japan-east`, `azure-north-europe`, `azure-uae-north`, `azure-us-east`, `azure-us-west-2`, `azure-us-west-3`. | `string` | n/a | yes |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | The verbosity of the logs produced by cloud-operator. Must be one of: `Debug`, `Info`, `Warn`, or `Error`. | `string` | `"Info"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the cloud-secure deployment in the k8s cluster. | `string` | n/a | yes |
| <a name="input_openshift_ovnk_namespace"></a> [openshift\_ovnk\_namespace](#input\_openshift\_ovnk\_namespace) | The namespace in which OpenShift OVN-k is deployed. | `string` | `"openshift-ovn-kubernetes"` | no |
| <a name="input_openshift_worker_node_cidrs"></a> [openshift\_worker\_node\_cidrs](#input\_openshift\_worker\_node\_cidrs) | The list of IP address CIDRs of the OpenShift cluster's worker nodes. Used to restrict access from only those nodes to the IPFIX collector on UDP port 4739 in the NetworkPolicy. | `list(string)` | `[]` | no |
| <a name="input_operator_namespace"></a> [operator\_namespace](#input\_operator\_namespace) | The k8s namespace where cloud-operator is to be deployed into. | `string` | `"illumio-cloud"` | no |
| <a name="input_operator_version"></a> [operator\_version](#input\_operator\_version) | The version of cloud-operator to be deployed into the k8s cluster. | `string` | `"v1.3.11"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The CloudSecure identifier of the onboarded k8s cluster. |
<!-- END_TF_DOCS -->