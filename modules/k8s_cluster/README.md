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
| <a name="input_additional_labels"></a> [additional\_labels](#input\_additional\_labels) | Optional k8s labels added to every cloud-operator resource. | `map(string)` | `{}` | no |
| <a name="input_aws_vpc_cni_auto_mode_node_proxy_log_collection_grant_nodes_proxy"></a> [aws\_vpc\_cni\_auto\_mode\_node\_proxy\_log\_collection\_grant\_nodes\_proxy](#input\_aws\_vpc\_cni\_auto\_mode\_node\_proxy\_log\_collection\_grant\_nodes\_proxy) | If true, grants the broad nodes/proxy RBAC permission for reading AWS EKS Auto Mode Network Policy Agent logs, in addition to nodes/log. Set to false on clusters running k8s >=1.33 to drop the broad permission and rely solely on nodes/log. | `bool` | `true` | no |
| <a name="input_aws_vpc_cni_auto_mode_node_proxy_log_collection_max_concurrent_node_polls"></a> [aws\_vpc\_cni\_auto\_mode\_node\_proxy\_log\_collection\_max\_concurrent\_node\_polls](#input\_aws\_vpc\_cni\_auto\_mode\_node\_proxy\_log\_collection\_max\_concurrent\_node\_polls) | The maximum number of AWS EKS Auto Mode Network Policy Agents polled concurrently. | `number` | `10` | no |
| <a name="input_aws_vpc_cni_auto_mode_node_proxy_log_collection_poll_interval"></a> [aws\_vpc\_cni\_auto\_mode\_node\_proxy\_log\_collection\_poll\_interval](#input\_aws\_vpc\_cni\_auto\_mode\_node\_proxy\_log\_collection\_poll\_interval) | The interval between polls of each AWS EKS Auto Mode Network Policy Agent log. | `string` | `"10s"` | no |
| <a name="input_cilium_namespaces"></a> [cilium\_namespaces](#input\_cilium\_namespaces) | The namespaces in which Cilium may be deployed. | `list(string)` | <pre>[<br/>  "kube-system",<br/>  "gke-managed-dpv2-observability",<br/>  "cilium"<br/>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the k8s cluster to be displayed in Illumio CloudSecure. If empty, defaults to the name of the cluster returned by the cloud provider's API, if configured. | `string` | `null` | no |
| <a name="input_create_operator_namespace"></a> [create\_operator\_namespace](#input\_create\_operator\_namespace) | If true, creates the k8s namespace where cloud-operator is to be deployed if it does not exist. | `bool` | `true` | no |
| <a name="input_flow_cache_active_timeout"></a> [flow\_cache\_active\_timeout](#input\_flow\_cache\_active\_timeout) | The maximum duration a flow stays in in-memory cache before being sent to Illumio CloudSecure. | `string` | `"20s"` | no |
| <a name="input_flow_cache_max_size"></a> [flow\_cache\_max\_size](#input\_flow\_cache\_max\_size) | The maximum number of flows that can be held in in-memory cache. | `number` | `1000` | no |
| <a name="input_https_proxy"></a> [https\_proxy](#input\_https\_proxy) | The URL of the HTTPS proxy to be used by cloud-operator to connect to Illumio CloudSecure. If not set, no proxy will be used. | `string` | `null` | no |
| <a name="input_illumio_region"></a> [illumio\_region](#input\_illumio\_region) | Illumio Region where the k8s cluster will be onboarded. An Illumio Region is a designated cloud region where the CloudSecure cloud-operator deployed in the k8s cluster connects after onboarding. Choose the Illumio Region nearest to the k8s cluster to maximize performance and security. Must be one of: `aws-ap-southeast-2`, `aws-eu-west-2`, `aws-me-central-1`, `aws-us-west-1`, `aws-us-west-2`, `azure-australia-east`, `azure-germany-west-central`, `azure-japan-east`, `azure-north-europe`, `azure-uae-north`, `azure-us-east`, `azure-us-west-2`, `azure-us-west-3`. | `string` | n/a | yes |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | The verbosity of the logs produced by cloud-operator. Must be one of: `Debug`, `Info`, `Warn`, or `Error`. | `string` | `"Info"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the cloud-secure deployment in the k8s cluster. | `string` | n/a | yes |
| <a name="input_openshift_create_anyuid_scc_role_binding"></a> [openshift\_create\_anyuid\_scc\_role\_binding](#input\_openshift\_create\_anyuid\_scc\_role\_binding) | If true, creates a k8s RoleBinding to OpenShift's system:openshift:scc:anyuid ClusterRole to allow cloud-operator to run with a non-root user. | `bool` | `true` | no |
| <a name="input_openshift_ovnk_namespace"></a> [openshift\_ovnk\_namespace](#input\_openshift\_ovnk\_namespace) | The namespace in which OpenShift OVN-k is deployed. | `string` | `"openshift-ovn-kubernetes"` | no |
| <a name="input_openshift_worker_node_cidrs"></a> [openshift\_worker\_node\_cidrs](#input\_openshift\_worker\_node\_cidrs) | The list of IP address CIDRs of the OpenShift cluster's worker nodes. Used to restrict access from only those nodes to the IPFIX collector on UDP port 4739 in the NetworkPolicy. If empty, defaults to allowing ingress traffic to UDP port 4739 from any address. This is a safe default only on clusters that are not running OpenShift with OVN-k, because port 4739 is not open in that case. | `list(string)` | `[]` | no |
| <a name="input_operator_namespace"></a> [operator\_namespace](#input\_operator\_namespace) | The k8s namespace where cloud-operator is to be deployed into. | `string` | `"illumio-cloud"` | no |
| <a name="input_operator_version"></a> [operator\_version](#input\_operator\_version) | The version of cloud-operator to be deployed into the k8s cluster. | `string` | `"v1.6.0"` | no |
| <a name="input_stats_log_period"></a> [stats\_log\_period](#input\_stats\_log\_period) | The interval between log entries with statistics about the network flows and resource mutations that were sent to the server. | `string` | `"30m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The CloudSecure identifier of the onboarded k8s cluster. |
<!-- END_TF_DOCS -->