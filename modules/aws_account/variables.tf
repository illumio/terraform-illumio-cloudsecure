variable "iam_name_prefix" {
  description = "The prefix given to all AWS IAM resource names."
  type        = string
  default     = "IllumioCloudIntegration"
  validation {
    condition     = length(var.iam_name_prefix) > 0
    error_message = "The iam_name_prefix value must not be empty."
  }
}

variable "illumio_cloudsecure_account_id" {
  description = "The CloudSecure AWS account ID that is given the IAM role."
  type        = string
  default     = "712001342241"
  validation {
    condition     = length(var.illumio_cloudsecure_account_id) == 12
    error_message = "The illumio_cloudsecure_account_id value must be a 12-digit number."
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
  description = "The name of this account in CloudSecure."
  type        = string
  validation {
    condition     = length(var.name) > 0
    error_message = "The name value must not be empty."
  }
}

variable "tags" {
  description = "The optional tags added to every configured AWS resource."
  type        = map(string)
  default     = {}
}

variable "role_arn" {
  description = "Optional. The ARN of a pre-existing IAM role to use instead of creating a new one. When set, the module skips creating the IAM role, its inline read/protection policies, the SecurityAudit attachment, and the random external ID. The supplied role must already trust the CloudSecure account via sts:AssumeRole with the supplied role_external_id and must carry the equivalent read (and, when mode = \"ReadWrite\", protection) permissions. role_external_id must also be set."
  type        = string
  nullable    = true
  default     = null
}

variable "role_external_id" {
  description = "Optional. The sts:ExternalId expected by the pre-existing IAM role identified by role_arn. Required when role_arn is set. Rotation of this value is the caller's responsibility."
  type        = string
  nullable    = true
  default     = null
  sensitive   = true
  validation {
    condition     = (var.role_arn == null) == (var.role_external_id == null)
    error_message = "role_arn and role_external_id must both be set or both be null."
  }
}

variable "account_id" {
  description = "Optional. The 12-digit AWS Account ID. When set, the module skips the aws_caller_identity data source lookup. Recommended for at-scale for_each patterns over many accounts."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = var.account_id == null || length(var.account_id) == 12
    error_message = "The account_id value must be a 12-digit number."
  }
}

variable "organization_id" {
  description = "Optional. The AWS Organizations organization ID (e.g., o-xxxxxxxxxx). When set, the module skips the aws_organizations_organization data source lookup, which is useful when the calling identity lacks organizations:DescribeOrganization or when running at scale."
  type        = string
  nullable    = true
  default     = null
}
