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

variable "azure_client_id" {
  type        = string
  description = "The client ID of the service principal used to authenticate against Azure."
}

variable "azure_client_secret" {
  type        = string
  sensitive   = true
  description = "The client secret of the service principal used to authenticate against Azure."
}

variable "azure_tenant_id" {
  type        = string
  description = "The Azure tenant ID."
}

variable "azure_subscription_id" {
  type        = string
  description = "The Azure subscription ID that owns the storage accounts."
}
