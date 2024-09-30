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

variable "illumio_cloudsecure_client_id" {
  type        = string
  description = "The OAuth 2 client identifier used to authenticate against the CloudSecure Config API."
}

variable "illumio_cloudsecure_client_secret" {
  type        = string
  sensitive   = true
  description = "The OAuth 2 client secret used to authenticate against the CloudSecure Config API."
}

variable "flow_logs_bucket_arns" {
    description = "List of S3 bucket arns (with path if needed) having flow logs"
    type        = list(string)
    default     = []
}