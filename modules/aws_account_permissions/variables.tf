# ---------------------------------------------------------------------------------------------------------------------
# Required PARAMETERS
# These variables have default values and can be modified based on the requirement.
# ---------------------------------------------------------------------------------------------------------------------


variable "iam_role_name" {
  description = "Customize the name of IAM role for Illumio AWS integration"
  type        = string
  default     = "IllumioCloudIntegrationRole"
  validation {
    condition     = length(var.iam_role_name) > 1
    error_message = "The IAM role name cannot be empty."
  }
}

variable "access_mode" {
  description = "integration mode Read/ReadWrite."
  type        = string
  default     = "ReadWrite"
  validation {
    condition     = contains(["Read", "ReadWrite"], var.access_mode)
    error_message = "Must be Read or ReadWrite"
  }
}


variable "flow_logs_buckets" {
  description = "List of S3 buckets having flow logs"
  type        = list(string)
  default     = []
}