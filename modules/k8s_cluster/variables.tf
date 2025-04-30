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
  description = "The HTTPS proxy to be used by the cloud-operator. If not set, no proxy will be used."
  type        = string
  default     = ""
}

variable "illumio_region" {
  description = "Illumio Region where the k8s cluster will be onboarded. An Illumio Region is a designated cloud region where the CloudSecure cloud-operator deployed in the k8s cluster connects after onboarding. Choose the Illumio Region nearest to the k8s cluster to maximize performance and security. Must be one of: `aws-ap-southeast-2`, `aws-eu-west-2`, `aws-us-west-2`, `aws-us-west-1`, `aws-eu-west-2`, `azure-us-east-2`, `azure-germany-west-central`, `azure-us-west-2`."
  type        = string
}

variable "name" {
  description = "The name of the cloud-secure deployment in the k8s cluster."
  type        = string
}

variable "operator_namespace" {
  description = "The k8s namespace where cloud-operator is to be deployed into."
  type        = string
  default     = "illumio-cloud"
}

variable "operator_version" {
  description = "The version of cloud-operator to be deployed into the k8s cluster."
  type        = string
  default     = "v1.1.3"
}
