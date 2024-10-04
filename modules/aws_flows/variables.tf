variable "flow_logs_bucket_arns" {
  description = "List of S3 buckets having flow logs"
  type        = list(string)
  validation {
    condition     = length(var.flow_logs_bucket_arns) > 0
    error_message = "The flow_logs_bucket_arns value must not be empty."
  }
}

variable "role_name" {
  description = "The name of the IAM role granted to the CloudSecure account."
  type        = string
  validation {
    condition     = length(var.role_name) > 1
    error_message = "The role_name value must not be empty."
  }
}