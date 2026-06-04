variable "account_id" {
  type        = string
  description = "The 12-digit AWS Account ID used by the at-scale example to skip the aws_caller_identity data source."
  validation {
    condition     = length(var.account_id) == 12
    error_message = "The account_id value must be a 12-digit number."
  }
}

variable "illumio_cloudsecure_client_id" {
  type        = string
  description = "The OAuth 2 client identifier used to authenticate against the CloudSecure Config API."
  validation {
    condition     = length(var.illumio_cloudsecure_client_id) > 0
    error_message = "The illumio_cloudsecure_client_id value must not be empty."
  }
}

variable "illumio_cloudsecure_client_secret" {
  type        = string
  sensitive   = true
  description = "The OAuth 2 client secret used to authenticate against the CloudSecure Config API."
  validation {
    condition     = length(var.illumio_cloudsecure_client_secret) > 0
    error_message = "The illumio_cloudsecure_client_secret value must not be empty."
  }
}

variable "organization_id" {
  type        = string
  description = "The AWS Organizations organization ID (e.g., o-xxxxxxxxxx) used by the at-scale example to skip the aws_organizations_organization data source."
  validation {
    condition     = length(var.organization_id) > 0
    error_message = "The organization_id value must not be empty."
  }
}

variable "role_arn" {
  type        = string
  description = "The ARN of a pre-existing IAM role to wire into the BYO-role example module instances."
  validation {
    condition     = length(var.role_arn) > 0
    error_message = "The role_arn value must not be empty."
  }
}

variable "role_external_id" {
  type        = string
  sensitive   = true
  description = "The sts:ExternalId expected by the pre-existing IAM role referenced by role_arn."
  validation {
    condition     = length(var.role_external_id) > 0
    error_message = "The role_external_id value must not be empty."
  }
}
