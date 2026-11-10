variable "blocked_encryption_types" {
  description = "The encryption types rejected on upload into the bucket. If null, the S3 default is left in place."
  type        = list(string)
  nullable    = true
  default     = ["SSE-C"]
}

variable "bucket_key_enabled" {
  description = "If true, enables S3 Bucket Keys, which cut the cost of SSE-KMS requests."
  type        = bool
  default     = true
}

variable "cross_account_reader_actions" {
  description = "The S3 actions granted to cross_account_reader_arns. The default is read-only; widening it can let those principals delete or overwrite log files."
  type        = list(string)
  default     = ["s3:GetObject", "s3:ListBucket", "s3:GetBucketLocation"]
  validation {
    condition     = length(var.cross_account_reader_actions) > 0
    error_message = "The cross_account_reader_actions value must not be empty."
  }
}

variable "cross_account_reader_arns" {
  description = "The ARNs of the IAM principals from other accounts that are granted access to the bucket. If empty, no cross-account statement is added to the bucket policy."
  type        = list(string)
  default     = []
}

variable "force_destroy" {
  description = "If true, allows Terraform to delete the bucket even when it still contains log files."
  type        = bool
  default     = false
}

variable "is_organization_trail" {
  description = "If true, grants write access to an organization trail instead of a trail of the bucket's account. The bucket policy then uses the ID of the organization's management account, which owns the trail even when a delegated administrator creates it, and also grants the `AWSLogs/<organization-id>/` path. Both IDs are looked up with the aws_organizations_organization data source, which requires the organizations:DescribeOrganization permission and returns the organization of the bucket's account, so the bucket's account must belong to the trail's organization. Must be the same as the is_organization_trail value of the aws_cloudtrail module."
  type        = bool
  default     = false
}

variable "kms_master_key_id" {
  description = "The KMS key used for the bucket's default encryption. Only applied when sse_algorithm is \"aws:kms\"."
  type        = string
  nullable    = true
  default     = null
}

variable "name" {
  description = "The name of the S3 bucket to create."
  type        = string
  validation {
    condition     = length(var.name) > 0
    error_message = "The name value must not be empty."
  }
}

variable "s3_key_prefix" {
  description = "The prefix prepended to the AWSLogs/ path inside the bucket. If null, no prefix is used."
  type        = string
  nullable    = true
  default     = null
  validation {
    # A conditional instead of ||, which evaluates both operands before Terraform 1.12.
    condition     = var.s3_key_prefix == null ? true : length(var.s3_key_prefix) <= 200 && !can(regex("^/|/$|//", var.s3_key_prefix))
    error_message = "The s3_key_prefix value must be at most 200 characters long and must not start with, end with, or contain repeated \"/\" characters."
  }
}

variable "sse_algorithm" {
  description = "The bucket's default server-side encryption algorithm. Must be one of: `AES256`, `aws:kms`."
  type        = string
  default     = "AES256"
  validation {
    condition     = contains(["AES256", "aws:kms"], var.sse_algorithm)
    error_message = "The sse_algorithm value must be \"AES256\" or \"aws:kms\"."
  }
}

variable "tags" {
  description = "The optional tags added to every configured AWS resource."
  type        = map(string)
  default     = {}
}

variable "trail_name" {
  description = "The name of the CloudTrail trail allowed to write into the bucket, used in the aws:SourceArn condition of the bucket policy. Must be the same as the name value of the aws_cloudtrail module. Unless is_organization_trail is true, the trail must belong to the same AWS account as the bucket."
  type        = string
  validation {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9._-]{2,127}$", var.trail_name))
    error_message = "The trail_name value must be 3 to 128 characters long, start with a letter or a digit, and contain only letters, digits, \".\", \"_\", or \"-\"."
  }
}

variable "trail_region" {
  description = "The home Region of the CloudTrail trail, i.e., the Region of the AWS provider used by the aws_cloudtrail module. If null, defaults to the Region of the bucket. Only needed when the trail is created in a different Region than the bucket."
  type        = string
  nullable    = true
  default     = null
}

variable "versioning_enabled" {
  description = "If true, enables S3 versioning on the bucket. If false, no versioning configuration is managed at all."
  type        = bool
  default     = false
}
