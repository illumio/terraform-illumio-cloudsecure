variable "account_id" {
  description = "The 12-digit AWS Account ID that owns the S3 buckets. When null, the module resolves it from the aws_caller_identity data source."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = var.account_id == null || length(var.account_id) == 12
    error_message = "The account_id value must be a 12-digit number."
  }
}

variable "buckets" {
  description = "The set of existing S3 buckets receiving VPC flow logs to register with CloudSecure by name and (optional) path prefix. Customers usually already have flow logs delivered to these buckets; no bucket is created unless create_bucket is true."
  type = set(object({
    bucket_name = string
    path_prefix = optional(string)
  }))
  validation {
    condition     = length(var.buckets) > 0
    error_message = "The buckets value must not be empty."
  }
  validation {
    condition     = alltrue([for b in var.buckets : length(b.bucket_name) > 0])
    error_message = "Every bucket_name value must not be empty."
  }
}

variable "create_bucket" {
  description = "When true, create each S3 bucket and attach a bucket policy that allows VPC flow log delivery. Defaults to false because customers usually already have a bucket receiving flow logs. Configuring the VPC flow log delivery itself remains the caller's responsibility."
  type        = bool
  default     = false
}

variable "role_id" {
  description = "The ID of the IAM role granted to the CloudSecure account (see the aws_account module's role_id output). When set, the module attaches an inline policy granting read access to the registered buckets. When null, granting CloudSecure read access to the buckets is the caller's responsibility."
  type        = string
  nullable    = true
  default     = null
}

variable "iam_name_prefix" {
  description = "The prefix given to all AWS IAM resource names created by this module."
  type        = string
  default     = "IllumioCloudIntegration"
  validation {
    condition     = length(var.iam_name_prefix) > 0
    error_message = "The iam_name_prefix value must not be empty."
  }
}

variable "tags" {
  description = "The optional tags added to every S3 bucket created when create_bucket is true."
  type        = map(string)
  default     = {}
}
