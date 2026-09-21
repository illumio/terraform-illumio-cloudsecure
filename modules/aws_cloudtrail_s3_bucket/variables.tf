variable "blocked_encryption_types" {
  description = "The encryption types rejected on upload into the bucket. If null, the S3 default is left in place."
  type        = list(string)
  nullable    = true
  default     = ["SSE-C"]
}

variable "bucket_key_enabled" {
  description = "If true, enables S3 Bucket Keys, which cut the cost of SSE-KMS requests. Has no effect while sse_algorithm is \"AES256\"."
  type        = bool
  default     = true
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create."
  type        = string
  validation {
    condition     = length(var.bucket_name) > 0
    error_message = "The bucket_name value must not be empty."
  }
}

variable "cross_account_reader_actions" {
  description = "The S3 actions granted to cross_account_reader_arns. The default is read-only; widening it lets the other account delete log files or replace the bucket policy."
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

variable "kms_master_key_id" {
  description = "The KMS key used for the bucket's default encryption. Only applied when sse_algorithm is \"aws:kms\"."
  type        = string
  nullable    = true
  default     = null
}

variable "log_account_id" {
  description = "The ID of the AWS account whose logs land in the bucket, i.e. the AWSLogs/<account-id>/ path granted by the bucket policy. If null, defaults to the caller's account."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = var.log_account_id == null || length(var.log_account_id) == 12
    error_message = "The log_account_id value must be a 12-digit number."
  }
}

variable "organization_id" {
  description = "The AWS Organizations organization ID (e.g., o-xxxxxxxxxx). When set, the bucket policy also grants the AWSLogs/<organization-id>/ path used by organization trails."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = var.organization_id == null || can(regex("^o-[a-z0-9]{10,32}$", var.organization_id))
    error_message = "The organization_id value must be an AWS Organizations organization ID, e.g. \"o-abc1234567\"."
  }
}

variable "s3_key_prefix" {
  description = "The prefix prepended to the AWSLogs/ path inside the bucket. If null, no prefix is used."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = var.s3_key_prefix == null || (length(var.s3_key_prefix) <= 200 && !can(regex("^/|/$|//", var.s3_key_prefix)))
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

variable "trail_arn" {
  description = "The ARN of the CloudTrail trail allowed to write into the bucket, used in the aws:SourceArn condition of the bucket policy."
  type        = string
  validation {
    condition     = length(var.trail_arn) > 0
    error_message = "The trail_arn value must not be empty."
  }
}

variable "versioning_enabled" {
  description = "If true, enables S3 versioning on the bucket. If false, no versioning configuration is managed at all."
  type        = bool
  default     = false
}
