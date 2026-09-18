variable "subscription_id" {
  description = "The ID of the Azure subscription that owns the storage accounts. When null, the module resolves it from the azurerm_subscription data source."
  type        = string
  nullable    = true
  default     = null
}

variable "storage_accounts" {
  description = "The set of existing storage accounts receiving flow logs to register with CloudSecure by name and (optional) container name and path prefix. resource_group_name is only required when service_principal_object_id is set so the module can grant blob read access."
  type = set(object({
    storage_account_name = string
    container_name       = optional(string)
    path_prefix          = optional(string)
    resource_group_name  = optional(string)
  }))
  validation {
    condition     = length(var.storage_accounts) > 0
    error_message = "The storage_accounts value must not be empty."
  }
  validation {
    condition     = alltrue([for a in var.storage_accounts : length(a.storage_account_name) > 0])
    error_message = "Every storage_account_name value must not be empty."
  }
  validation {
    condition     = var.service_principal_object_id == null || alltrue([for a in var.storage_accounts : a.resource_group_name != null && a.resource_group_name != ""])
    error_message = "Every storage account must set resource_group_name when service_principal_object_id is set so blob read access can be granted."
  }
}

variable "service_principal_object_id" {
  description = "The object (principal) ID of the service principal used by CloudSecure to read the storage accounts. When set, the module assigns the built-in \"Storage Blob Data Reader\" role to it on each storage account. When null, granting CloudSecure read access is the caller's responsibility."
  type        = string
  nullable    = true
  default     = null
}
