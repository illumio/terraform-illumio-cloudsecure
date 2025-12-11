variable "illumio_cloudsecure_client_id" {
  type        = string
  description = "The OAuth 2 client identifier used to authenticate against the CloudSecure Config API."
  validation {
    condition     = length(var.illumio_cloudsecure_client_id) > 0
    error_message = "The illumio_cloudsecure_client_id value must not be empty."
  }
}

variable "illumio_cloudsecure_client_secret" {
  type        = string
  sensitive   = true
  description = "The OAuth 2 client secret used to authenticate against the CloudSecure Config API."
  validation {
    condition     = length(var.illumio_cloudsecure_client_secret) > 0
    error_message = "The illumio_cloudsecure_client_secret value must not be empty."
  }
}

variable "gcp_project_id" {
  description = "The GCP Project ID."
  type        = string
  validation {
    condition     = length(var.gcp_project_id) > 0
    error_message = "The gcp_project_id value must not be empty."
  }
}

variable "gcp_org_id" {
  description = "The GCP Organization ID."
  type        = string
  validation {
    condition     = length(var.gcp_org_id) > 0
    error_message = "The gcp_org_id value must not be empty."
  }
}