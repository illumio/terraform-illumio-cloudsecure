variable "illumio_region" {
  description = "The Illumio region where the cluster is located."
  type        = string
}

variable "name" {
  description = "The name of the onboarding credential."
  type        = string
}

variable "description" {
  description = "The description of the onboarding credential."
  type        = string
  default     = null
}

variable "helm_release_name" {
  description = "The name of the Helm release."
  type        = string
}

variable "helm_chart" {
  description = "The Helm chart to deploy."
  type        = string
}

variable "helm_namespace" {
  description = "The Kubernetes namespace to deploy to."
  type        = string
}

variable "create_namespace" {
  description = "Create the Kubernetes namespace if it does not exist."
  type        = bool
}

variable "helm_version" {
  description = "The helm chart version"
  type        = string
}

variable "illumio_cloudsecure_client_id" {
  type        = string
  description = "The OAuth 2 client identifier used to authenticate against the CloudSecure Config API."
}

variable "illumio_cloudsecure_client_secret" {
  type        = string
  sensitive   = true
  description = "The OAuth 2 client secret used to authenticate against the CloudSecure Config API."
}