variable "iam_name_prefix" {
  description = "The prefix given to all Azure resource names."
  type        = string
  default     = "IllumioCloudIntegration"
  validation {
    condition     = length(var.iam_name_prefix) > 0
    error_message = "The iam_name_prefix value must not be empty."
  }
}

variable "service_principal_client_id" {
  type        = string
  description = "The client ID of the service principal used to access the storage accounts."
  validation {
    condition     = length(var.service_principal_client_id) > 0
    error_message = "The service_principal_client_id value must not be empty."
  }
}

variable "storage_accounts" {
  type = set(object({
    name                = string
    resource_group_name = string
  }))
  description = "The set of storage accounts to retrieve information for."
  default     = []
}