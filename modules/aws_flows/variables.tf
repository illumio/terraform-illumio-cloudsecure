variable "flow_logs_bucket_arns" {
  description = "List of S3 buckets having flow logs"
  type        = list(string)
  validation {
    condition     = length(var.flow_logs_bucket_arns) > 0
    error_message = "The flow_logs_bucket_arns value must not be empty."
  }
}

variable "role_arn" {
  description = "The ARN of the IAM role granted to the CloudSecure account."
  type        = string
  validation {
    condition     = length(var.role_arn) > 1
    error_message = "The role_arn value must not be empty."
  }
}