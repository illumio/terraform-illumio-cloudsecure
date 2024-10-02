variable "iam_name_prefix" {
  description = "The prefix given to all AWS IAM resource names."
  type        = string
  default     = "IllumioCloudIntegration"
  validation {
    condition     = length(var.iam_name_prefix) > 1
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

variable "illumio_cloudsecure_account_id" {
  description = "The CloudSecure AWS account ID that is given the IAM role."
  type        = string
  default     = "712001342241"
  validation {
    condition     = length(var.illumio_cloudsecure_account_id) > 1
    error_message = "The illumio_cloudsecure_account_id value must not be empty."
  }
}

variable "name" {
  description = "The name of this account in CloudSecure."
  type        = string
  validation {
    condition     = length(var.name) > 1
    error_message = "The name value must not be empty."
  }
}

variable "tags" {
  description = "The optional tags added to every configured AWS resource."
  type        = map(string)
  default     = {}
}