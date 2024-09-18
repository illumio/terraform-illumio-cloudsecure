variable "illumio_region" {
  description = "The Illumio region where the Kubernetes cluster is located."
  type        = string
  default     = "aws-us-west-2"
}

variable "name" {
  description = "The name of the onboarding credential and Helm release."
  type        = string
  default     = "example-release"
}

variable "description" {
  description = "The description of the onboarding credential."
  type        = string
  default     = "Credential to onboard dev clusters in aws-us-west-2 illumio region"
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