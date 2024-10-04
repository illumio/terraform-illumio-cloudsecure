variable "flow_logs_bucket_arns" {
  type        = list(string)
  description = "List of S3 buckets having flow logs"
  validation {
    condition     = length(var.flow_logs_bucket_arns) > 0
    error_message = "The flow_logs_bucket_arns value must not be empty."
  }
}

variable "illumio_cloudsecure_client_id" {
  type        = string
  description = "The OAuth 2 client identifier used to authenticate against the CloudSecure Config API."
  validation {
    condition     = length(var.illumio_cloudsecure_client_id) > 1
    error_message = "The illumio_cloudsecure_client_id value must not be empty."
  }
}

variable "illumio_cloudsecure_client_secret" {
  type        = string
  sensitive   = true
  description = "The OAuth 2 client secret used to authenticate against the CloudSecure Config API."
  validation {
    condition     = length(var.illumio_cloudsecure_client_secret) > 1
    error_message = "The illumio_cloudsecure_client_secret value must not be empty."
  }
}

variable "illumio_cloudsecure_role_arn" {
  type        = string
  description = "The ARN of the IAM role granted to the CloudSecure account."
  validation {
    condition     = length(var.illumio_cloudsecure_role_arn) > 1
    error_message = "The illumio_cloudsecure_role_arn value must not be empty."
  }
}

