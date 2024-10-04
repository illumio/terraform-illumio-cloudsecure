variable "iam_name_prefix" {
  description = "The prefix given to all AWS IAM resource names."
  type        = string
  default     = "IllumioCloudIntegration"
  validation {
    condition     = length(var.iam_name_prefix) > 1
    error_message = "The iam_name_prefix value must not be empty."
  }
}

variable "role_id" {
  description = "The ID of the IAM role granted to the CloudSecure account."
  type        = string
  validation {
    condition     = length(var.role_id) > 1
    error_message = "The role_id value must not be empty."
  }
}

variable "s3_bucket_arns" {
  description = "The set of ARNs of AWS S3 buckets containing flow logs."
  type        = set(string)
  validation {
    condition     = length(var.s3_bucket_arns) > 1
    error_message = "The s3_bucket_arns value must not be empty."
  }
}