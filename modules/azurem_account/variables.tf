variable "application_name" {
  type    = string
  default = "Illumio-CloudSecure-Access"
  validation {
    condition     = length(var.application_name) > 0
    error_message = "The name value must not be empty."
  }
}

variable "application_secret_name" {
  type    = string
  default = "Illumio-CloudSecure-Secret"
  validation {
      condition     = length(var.application_secret_name) > 0
      error_message = "The secret_name value must not be empty."
  }
}

variable "firewall_role_name" {
  type    = string
  default = "Illumio Firewall Administrator"
  validation {
    condition     = length(var.firewall_role_name) > 0
    error_message = "The role_name value must not be empty."
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

variable "nsg_role_name" {
    type    = string
    default = "Illumio Network Security Administrator"
    validation {
        condition     = length(var.nsg_role_name) > 0
        error_message = "The nsg_role_name value must not be empty."
    }
}

variable "secret_expiration_days" {
  type    = number
  default = 365
  description = "The number of days the secret will be valid."
  validation {
    condition     = var.secret_expiration_days > 0
    error_message = "The secret_expiration_days value must be greater than 0."
  }
}

variable "subscription_id" {
  type    = string
  description = "The subscription ID of the Azure account."
}

variable "tenant_id" {
  type    = string
  description = "The tenant ID of the Azure account."
  validation {
    condition     = length(var.tenant_id) > 0
    error_message = "The tenant ID value must not be empty."
  }
}