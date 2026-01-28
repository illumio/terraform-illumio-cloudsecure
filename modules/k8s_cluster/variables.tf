variable "cilium_namespaces" {
  description = "The namespaces in which Cilium may be deployed."
  type        = list(string)
  default     = [
    "kube-system",
    "gke-managed-dpv2-observability"
  ]
}

variable "create_operator_namespace" {
  description = "If true, creates the k8s namespace where cloud-operator is to be deployed if it does not exist."
  type        = bool
  default     = true
}

variable "enable_falco" {
  description = "If true, deploys the Falco agent along with cloud-operator to collect network flows."
  type        = bool
  default     = false
}

variable "https_proxy" {
  description = "The URL of the HTTPS proxy to be used by cloud-operator to connect to Illumio CloudSecure. If not set, no proxy will be used."
  type        = string
  nullable    = true
  default     = null
}

variable "illumio_region" {
  description = "Illumio Region where the k8s cluster will be onboarded. An Illumio Region is a designated cloud region where the CloudSecure cloud-operator deployed in the k8s cluster connects after onboarding. Choose the Illumio Region nearest to the k8s cluster to maximize performance and security. Must be one of: `aws-ap-southeast-2`, `aws-eu-west-2`, `aws-me-central-1`, `aws-us-west-1`, `aws-us-west-2`, `azure-australia-east`, `azure-germany-west-central`, `azure-japan-east`, `azure-north-europe`, `azure-uae-north`, `azure-us-east`, `azure-us-west-2`, `azure-us-west-3`."
  type        = string
}

variable "log_level" {
  description = "The verbosity of the logs produced by cloud-operator. Must be one of: `Debug`, `Info`, `Warn`, or `Error`."
  type        = string
  default     = "Info"
}

variable "name" {
  description = "The name of the cloud-secure deployment in the k8s cluster."
  type        = string
}

variable "openshift_ovnk_namespace" {
  description = "The namespace in which OpenShift OVN-k is deployed."
  type        = string
  default     = "openshift-ovn-kubernetes"
}

variable "openshift_worker_node_cidrs" {
  description = "The list of IP address CIDRs of the OpenShift cluster's worker nodes. Used to restrict access from only those nodes to the IPFIX collector on UDP port 4739 in the NetworkPolicy. If empty, defaults to allowing ingress traffic to UDP port 4739 from any address. This is a safe default only on clusters that are not running OpenShift with OVN-k, because port 4739 is not open in that case."
  type        = list(string)
  default     = []
}

variable "operator_namespace" {
  description = "The k8s namespace where cloud-operator is to be deployed into."
  type        = string
  default     = "illumio-cloud"
}

variable "operator_version" {
  description = "The version of cloud-operator to be deployed into the k8s cluster."
  type        = string
  default     = "v1.3.11"
}
