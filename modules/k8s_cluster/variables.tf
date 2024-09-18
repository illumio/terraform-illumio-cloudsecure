variable "illumio_region" {
  description = "Illumio Region where the k8s cluster can be onboarded using this credential. An Illumio Region is a designated cloud region where the CloudSecure k8s operators in onboarded k8s clusters connect after onboarding. Choose the Illumio Region nearest to each cluster to maximize performance and security. Must be one of: `aws-ap-southeast-2`, `aws-eu-west-2`, `aws-us-west-2`."
  type        = string
}

variable "name" {
  description = "The name of the cloud-secure deployment in the k8s cluster and of the CloudSecure onboarding credential used to onboard the k8s cluster."
  type        = string
}

variable "description" {
  description = "The description of the CloudSecure onboarding credential used to onboard the k8s cluster."
  type        = string
  default     = ""
}

variable "operator_namespace" {
  description = "The k8s namespace where cloud-operator is to be deployed into."
  type        = string
  default     = "illumio-cloud"
}

variable "create_operator_namespace" {
  description = "If true, creates the k8s namespace where cloud-operator is to be deployed if it does not exist."
  type        = bool
  default     = true
}

variable "operator_version" {
  description = "The version of cloud-operator to be deployed into the k8s cluster."
  type        = string
  default     = "v0.0.3"
}
