variable "account_id" {
  description = "The 12-digit AWS Account ID. When set, the module skips the aws_caller_identity data source lookup. Recommended for at-scale for_each patterns over many accounts."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = var.account_id == null || length(var.account_id) == 12
    error_message = "The account_id value must be a 12-digit number."
  }
}

variable "cloudtrail_enable_log_file_validation" {
  description = "Whether log file integrity validation is enabled on the CloudTrail trail created when create_cloudtrail is true."
  type        = bool
  default     = true
}

variable "cloudtrail_include_global_service_events" {
  description = "Whether the CloudTrail trail created when create_cloudtrail is true records events from global services such as IAM."
  type        = bool
  default     = true
}

variable "cloudtrail_is_multi_region_trail" {
  description = "Whether the CloudTrail trail created when create_cloudtrail is true is a multi-region trail."
  type        = bool
  default     = true
}

variable "cloudtrail_name" {
  description = "The name of the CloudTrail trail created when create_cloudtrail is true. Defaults to \"<iam_name_prefix>Trail\" when null."
  type        = string
  nullable    = true
  default     = null
}

variable "cloudtrail_s3_bucket_name" {
  description = "The name of a pre-existing S3 bucket that the CloudTrail trail delivers logs to. Required when create_cloudtrail is true. The bucket must already grant CloudTrail (cloudtrail.amazonaws.com) permission to deliver logs."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = !var.create_cloudtrail || (var.cloudtrail_s3_bucket_name != null && var.cloudtrail_s3_bucket_name != "")
    error_message = "cloudtrail_s3_bucket_name must be set when create_cloudtrail is true."
  }
}

variable "create_cloudtrail" {
  description = "Whether to create a CloudTrail trail as part of onboarding. Defaults to false because most accounts already have a trail. When true, cloudtrail_s3_bucket_name must be set."
  type        = bool
  default     = false
}

variable "existing_cloudtrail_present" {
  description = "Whether a CloudTrail trail already exists in this account. Used together with require_cloudtrail to gate onboarding. The provider exposes no data source to detect trails, so this is a caller-supplied assertion. Ignored unless require_cloudtrail is true."
  type        = bool
  default     = false
}

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

variable "organization_id" {
  description = "The AWS Organizations organization ID (e.g., o-xxxxxxxxxx). When set, the module skips the aws_organizations_organization data source lookup, which is useful when the calling identity lacks the organizations:DescribeOrganization permission or when running at scale."
  type        = string
  nullable    = true
  default     = null
}

variable "require_cloudtrail" {
  description = "Whether onboarding requires a CloudTrail trail. When true, onboarding fails unless a trail is created (create_cloudtrail) or asserted to exist (existing_cloudtrail_present). Defaults to false to preserve existing behavior."
  type        = bool
  default     = false
}

variable "role_arn" {
  description = "The ARN of a pre-existing IAM role to use instead of creating a new one. When set, the module skips creating the IAM role, its inline read/protection policies, the SecurityAudit attachment, and the random external ID. The supplied role must already trust the CloudSecure account via sts:AssumeRole with the supplied role_external_id and must carry the equivalent read (and, when mode = \"ReadWrite\", protection) permissions. role_external_id must also be set."
  type        = string
  nullable    = true
  default     = null
}

variable "role_external_id" {
  description = "The sts:ExternalId expected by the pre-existing IAM role identified by role_arn. Required when role_arn is set. Rotation of this value is the caller's responsibility."
  type        = string
  nullable    = true
  default     = null
  sensitive   = true
  validation {
    condition     = (var.role_arn == null) == (var.role_external_id == null)
    error_message = "role_arn and role_external_id must both be set or both be null."
  }
}

variable "tags" {
  description = "The optional tags added to every configured AWS resource."
  type        = map(string)
  default     = {}
}
