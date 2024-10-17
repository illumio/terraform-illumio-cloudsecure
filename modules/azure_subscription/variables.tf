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
  description = "The name of this account in CloudSecure."
  type        = string
  validation {
    condition     = length(var.name) > 0
    error_message = "The name value must not be empty."
  }
}
variable "secret_expiration_days" {
  type        = number
  default     = 365
  description = "The number of days the secret will be valid."
  validation {
    condition     = var.secret_expiration_days > 0
    error_message = "The secret_expiration_days value must be greater than 0."
  }
}

variable "subscription_id" {
  type        = string
  description = "The subscription ID of the Azure account."
  validation {
    condition     = length(var.subscription_id) > 0
    error_message = "The subscription ID value must not be empty."
  }
}

variable "tags" {
  description = "The optional tags added to every configured AWS resource."
  type        = set(string)
  default     = []
}