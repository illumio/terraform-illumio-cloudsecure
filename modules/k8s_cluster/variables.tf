variable "illumio_region" {
  description = "The Illumio region where the cluster is located."
  type        = string
}

variable "name" {
  description = "The name of the cloud-secure deployment in the k8s cluster and of the CloudSecure onboarding credential used to onboard the k8s cluster."
  type        = string
}

variable "description" {
  description = "The description of the CloudSecure onboarding credential used to onboard the k8s cluster."
  type        = string
  default     = null
}

variable "namespace" {
  description = "The k8s namespace where cloud-operator is to be deployed into."
  type        = string
  default     = "illumio-cloud"
}

variable "create_namespace" {
  description = "If true, creates the k8s namespace where cloud-operator is to be deployed if it does not exist."
  type        = bool
  default     = true
}

variable "version" {
  description = "The version of cloud-operator to be deployed into the k8s cluster."
  type        = string
  default     = "v1.0.9"
}
