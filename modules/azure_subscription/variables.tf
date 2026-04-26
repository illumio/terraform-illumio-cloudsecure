variable "iam_name_prefix" {
  description = "The prefix given to all Azure resource names."
  type        = string
  default     = "IllumioCloudIntegration"
  validation {
    condition     = length(var.iam_name_prefix) > 0
    error_message = "The iam_name_prefix value must not be empty."
  }
}

variable "mode" {
  description = "The account's access mode, must be \"ReadWrite\" (default) or \"Read\"."
  type        = string
  default     = "ReadWrite"
  validation {
    condition     = contains(["Read", "ReadWrite"], var.mode)
    error_message = "The mode value must be \"ReadWrite\" or \"Read\"."
  }
}

variable "name" {
  description = "The name of this subscription in CloudSecure."
  type        = string
  validation {
    condition     = length(var.name) > 0
    error_message = "The name value must not be empty."
  }
}

variable "azure_secret_expiration_days" {
  type        = number
  default     = 365
  description = "The number of days the Azure service principal secret remains valid before requiring renewal."
  validation {
    condition     = var.azure_secret_expiration_days > 0
    error_message = "The azure_secret_expiration_days value must be greater than 0."
  }
}

variable "tags" {
  description = "The optional tags added to every configured Azure resource."
  type        = set(string)
  default     = []
}

variable "service_principal_client_id" {
  description = "Optional. The client ID (application ID) of a pre-existing Azure AD application to use instead of creating a new one. When set, the module skips creating the azuread_application, azuread_service_principal, and azuread_application_password resources and looks up the existing service principal by client_id (which requires the executing identity to have directory read access). service_principal_client_secret must also be set."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = (var.service_principal_client_id == null) == (var.service_principal_client_secret == null)
    error_message = "service_principal_client_id and service_principal_client_secret must both be set or both be null."
  }
}

variable "service_principal_client_secret" {
  description = "Optional. The client secret for the pre-existing Azure AD application identified by service_principal_client_id. Required when service_principal_client_id is set. Rotation of this secret is the caller's responsibility; azure_secret_expiration_days is ignored in this mode."
  type        = string
  nullable    = true
  default     = null
  sensitive   = true
  validation {
    condition     = (var.service_principal_client_id == null) == (var.service_principal_client_secret == null)
    error_message = "service_principal_client_id and service_principal_client_secret must both be set or both be null."
  }
}