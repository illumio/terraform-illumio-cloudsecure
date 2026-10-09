variable "advanced_event_selectors" {
  description = "The advanced event selectors of the trail. The default logs management events plus data events for S3 objects, DynamoDB tables, DSQL clusters, Lambda functions, and RDS DB clusters. Data events are billed per event, so narrow or drop those entries to cut cost. For best threat detection, we recommend enabling all these events, but threat detection still works with only management events enabled."
  type = list(object({
    name = optional(string)
    field_selector = list(object({
      field           = string
      equals          = optional(list(string))
      not_equals      = optional(list(string))
      starts_with     = optional(list(string))
      not_starts_with = optional(list(string))
      ends_with       = optional(list(string))
      not_ends_with   = optional(list(string))
    }))
  }))
  # For best threat detection, we recommend enabling all these events, but
  # threat detection still works with only management events enabled.
  default = [
    {
      field_selector = [
        {
          field  = "eventCategory"
          equals = ["Data"]
        },
        {
          field  = "resources.type"
          equals = ["AWS::S3::Object"]
        }
      ]
    },
    {
      field_selector = [
        {
          field  = "eventCategory"
          equals = ["Data"]
        },
        {
          field  = "resources.type"
          equals = ["AWS::DynamoDB::Table"]
        }
      ]
    },
    {
      field_selector = [
        {
          field  = "eventCategory"
          equals = ["Data"]
        },
        {
          field  = "resources.type"
          equals = ["AWS::DSQL::Cluster"]
        }
      ]
    },
    {
      field_selector = [
        {
          field  = "eventCategory"
          equals = ["Data"]
        },
        {
          field  = "resources.type"
          equals = ["AWS::Lambda::Function"]
        }
      ]
    },
    {
      field_selector = [
        {
          field  = "eventCategory"
          equals = ["Data"]
        },
        {
          field  = "resources.type"
          equals = ["AWS::RDS::DBCluster"]
        }
      ]
    },
    {
      name = "Management events selector"
      field_selector = [
        {
          field  = "eventCategory"
          equals = ["Management"]
        }
      ]
    }
  ]
  validation {
    condition     = length(var.advanced_event_selectors) > 0
    error_message = "The advanced_event_selectors value must not be empty."
  }
}

variable "bucket_blocked_encryption_types" {
  description = "The encryption types rejected on upload into the log bucket. If null, the S3 default is left in place. Only used when create_s3_bucket is true."
  type        = list(string)
  nullable    = true
  default     = ["SSE-C"]
}

variable "bucket_force_destroy" {
  description = "If true, allows Terraform to delete the log bucket even when it still contains log files. Only used when create_s3_bucket is true."
  type        = bool
  default     = false
}

variable "bucket_key_enabled" {
  description = "If true, enables S3 Bucket Keys on the log bucket, which cut the cost of SSE-KMS requests. Has no effect while bucket_sse_algorithm is \"AES256\". Only used when create_s3_bucket is true."
  type        = bool
  default     = true
}

variable "bucket_kms_master_key_id" {
  description = "The KMS key used for the log bucket's default encryption. Only applied when create_s3_bucket is true and bucket_sse_algorithm is \"aws:kms\"."
  type        = string
  nullable    = true
  default     = null
}

variable "bucket_sse_algorithm" {
  description = "The log bucket's default server-side encryption algorithm. Must be one of: `AES256`, `aws:kms`. Only used when create_s3_bucket is true."
  type        = string
  default     = "AES256"
  validation {
    condition     = contains(["AES256", "aws:kms"], var.bucket_sse_algorithm)
    error_message = "The bucket_sse_algorithm value must be \"AES256\" or \"aws:kms\"."
  }
}

variable "bucket_versioning_enabled" {
  description = "If true, enables S3 versioning on the log bucket. Only used when create_s3_bucket is true."
  type        = bool
  default     = false
}

variable "cloud_watch_logs_group_arn" {
  description = "The ARN of the CloudWatch Logs log stream the trail delivers events to. Must be set together with cloud_watch_logs_role_arn."
  type        = string
  nullable    = true
  default     = null
}

variable "cloud_watch_logs_role_arn" {
  description = "The ARN of the IAM role CloudTrail assumes to write into CloudWatch Logs. Must be set together with cloud_watch_logs_group_arn."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = (var.cloud_watch_logs_group_arn == null) == (var.cloud_watch_logs_role_arn == null)
    error_message = "The cloud_watch_logs_group_arn and cloud_watch_logs_role_arn values must both be set or both be null."
  }
}

variable "create_s3_bucket" {
  description = "If true, creates the log bucket, its bucket policy, encryption and public access block in this module. Set to false to reuse an existing bucket, e.g. a bucket in another Region, which a module cannot create because it cannot select a provider conditionally."
  type        = bool
  default     = true
}

variable "cross_account_reader_actions" {
  description = "The S3 actions granted to cross_account_reader_arns. The default is read-only; widening it lets the other account delete log files or replace the bucket policy. Only used when create_s3_bucket is true."
  type        = list(string)
  default     = ["s3:GetObject", "s3:ListBucket", "s3:GetBucketLocation"]
  validation {
    condition     = length(var.cross_account_reader_actions) > 0
    error_message = "The cross_account_reader_actions value must not be empty."
  }
}

variable "cross_account_reader_arns" {
  description = "The ARNs of the IAM principals from other accounts that are granted access to the log bucket. Only used when create_s3_bucket is true."
  type        = list(string)
  default     = []
}

variable "enable_log_file_validation" {
  description = "If true, delivers digest files so the integrity of the log files can be verified."
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "If true, starts logging right after the trail is created."
  type        = bool
  default     = true
}

variable "include_global_service_events" {
  description = "If true, includes events from global services such as IAM."
  type        = bool
  default     = true
}

variable "insight_types" {
  description = "The CloudTrail Insights types to enable. May contain `ApiCallRateInsight` and/or `ApiErrorRateInsight`."
  type        = list(string)
  default     = []
  validation {
    condition     = alltrue([for t in var.insight_types : contains(["ApiCallRateInsight", "ApiErrorRateInsight"], t)])
    error_message = "The insight_types value must only contain \"ApiCallRateInsight\" and/or \"ApiErrorRateInsight\"."
  }
}

variable "is_multi_region_trail" {
  description = "If true, captures events from every Region. If false, only the trail's home Region is captured, although global service events still arrive when include_global_service_events is true."
  type        = bool
  default     = true
}

variable "is_organization_trail" {
  description = "If true, creates an organization trail. Requires running in the management account or in a delegated administrator account."
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The ARN or ID of the KMS key used for SSE-KMS on the delivered log files. If null, CloudTrail uses SSE-S3."
  type        = string
  nullable    = true
  default     = null
}

variable "name" {
  description = "The name of the CloudTrail trail."
  type        = string
  validation {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9._-]{2,127}$", var.name))
    error_message = "The name value must be 3 to 128 characters long, start with a letter or a digit, and contain only letters, digits, \".\", \"_\", or \"-\"."
  }
}

variable "organization_id" {
  description = "The AWS Organizations organization ID (e.g., o-xxxxxxxxxx) whose AWSLogs/<organization-id>/ path the log bucket policy grants. When null and both is_organization_trail and create_s3_bucket are true, the module looks the ID up with the aws_organizations_organization data source, which requires the organizations:DescribeOrganization permission."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = var.organization_id == null || can(regex("^o-[a-z0-9]{10,32}$", var.organization_id))
    error_message = "The organization_id value must be an AWS Organizations organization ID, e.g. \"o-abc1234567\"."
  }
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket that receives the log files. Created by this module when create_s3_bucket is true, otherwise it must already exist and already grant CloudTrail write access."
  type        = string
  validation {
    condition     = length(var.s3_bucket_name) > 0
    error_message = "The s3_bucket_name value must not be empty."
  }
}

variable "s3_key_prefix" {
  description = "The prefix prepended to the AWSLogs/ path inside the log bucket. If null, no prefix is used."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = var.s3_key_prefix == null || (length(var.s3_key_prefix) <= 200 && !can(regex("^/|/$|//", var.s3_key_prefix)))
    error_message = "The s3_key_prefix value must be at most 200 characters long and must not start with, end with, or contain repeated \"/\" characters."
  }
}

variable "sns_topic_name" {
  description = "The SNS topic that receives log file delivery notifications. If null, no notifications are sent."
  type        = string
  nullable    = true
  default     = null
}

variable "tags" {
  description = "The optional tags added to every configured AWS resource."
  type        = map(string)
  default     = {}
}
