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

variable "secret_expiration_days" {
  type        = number
  default     = 365
  description = "The number of days the secret will be valid."
  validation {
    condition     = var.secret_expiration_days > 0
    error_message = "The secret_expiration_days value must be greater than 0."
  }
}

variable "tags" {
  description = "The optional tags added to every configured Azure resource."
  type        = set(string)
  default     = []
}