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


variable "azure_subscription_id" {
  type        = string
  description = "The Azure Subscription ID."
  validation {
    condition     = length(var.azure_subscription_id) > 0
    error_message = "The azure_subscription_id value must not be empty."
  }
}

variable "azure_client_id" {
  type        = string
  description = "The Azure Client ID."
  validation {
    condition     = length(var.azure_client_id) > 0
    error_message = "The azure_client_id value must not be empty."
  }
}

variable "azure_client_secret" {
  type        = string
  sensitive   = true
  description = "The Azure Client Secret."
  validation {
    condition     = length(var.azure_client_secret) > 0
    error_message = "The azure_client_secret value must not be empty."
  }
}

variable "azure_tenant_id" {
  type        = string
  description = "The Azure Tenant ID."
  validation {
    condition     = length(var.azure_tenant_id) > 0
    error_message = "The azure_tenant_id value must not be empty."
  }
}