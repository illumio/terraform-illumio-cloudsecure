variable "cilium_namespaces" {
  description = "The namespaces in which Cilium may be deployed."
  type        = list(string)
  default     = [
    "kube-system",
    "gke-managed-dpv2-observability"
  ]
  validation {
    condition     = length(var.cilium_namespaces) > 0
    error_message = "The cilium_namespaces value must not be empty."
  }
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
  validation {
    condition     = length(var.illumio_region) > 0
    error_message = "The illumio_region value must not be empty."
  }
}

variable "log_level" {
  description = "The verbosity of the logs produced by cloud-operator. Must be one of: `Debug`, `Info`, `Warn`, or `Error`."
  type        = string
  default     = "Info"
  validation {
    condition     = contains(["Debug", "Info", "Warn", "Error"], var.log_level)
    error_message = "The log_level value must be \"Debug\", \"Info\", \"Warn\", or \"Error\"."
  }
}

variable "name" {
  description = "The name of the cloud-secure deployment in the k8s cluster."
  type        = string
  validation {
    condition     = length(var.name) > 0
    error_message = "The name value must not be empty."
  }
}

variable "openshift_ovnk_namespace" {
  description = "The namespace in which OpenShift OVN-k is deployed."
  type        = string
  default     = "openshift-ovn-kubernetes"
  validation {
    condition     = length(var.openshift_ovnk_namespace) > 0
    error_message = "The openshift_ovnk_namespace value must not be empty."
  }
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
  validation {
    condition     = length(var.operator_namespace) > 0
    error_message = "The operator_namespace value must not be empty."
  }
}

variable "operator_version" {
  description = "The version of cloud-operator to be deployed into the k8s cluster."
  type        = string
  default     = "v1.3.11"
  validation {
    condition     = length(var.operator_version) > 0
    error_message = "The operator_version value must not be empty."
  }
}
