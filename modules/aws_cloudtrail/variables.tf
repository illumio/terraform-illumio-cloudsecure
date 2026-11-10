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

variable "cloud_watch_logs_group_arn" {
  description = "The ARN of the CloudWatch Logs log group the trail delivers events to, followed by the log stream wildcard `:*`. Must be set together with cloud_watch_logs_role_arn."
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
  description = "If true, captures events from every Region. If false, only the trail's home Region is captured, and global service events are delivered only if the home Region is the partition's leader Region (e.g., us-east-1), even when include_global_service_events is true."
  type        = bool
  default     = true
}

variable "is_organization_trail" {
  description = "If true, creates an organization trail. Requires running in the management account or in a delegated administrator account. Must be the same as the is_organization_trail value of the aws_cloudtrail_s3_bucket module."
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The ARN of the KMS key used for SSE-KMS on the delivered log files. The key must be in the same Region as the S3 bucket. If null, CloudTrail uses SSE-S3."
  type        = string
  nullable    = true
  default     = null
}

variable "name" {
  description = "The name of the CloudTrail trail. Must be the same as the trail_name value of the aws_cloudtrail_s3_bucket module."
  type        = string
  validation {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9._-]{2,127}$", var.name))
    error_message = "The name value must be 3 to 128 characters long, start with a letter or a digit, and contain only letters, digits, \".\", \"_\", or \"-\"."
  }
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket that receives the log files. The bucket must be created with the aws_cloudtrail_s3_bucket module, which also onboards it with CloudSecure. Must be set from the s3_bucket_name output of that module, so that the trail is created after the bucket policy and after the bucket is onboarded."
  type        = string
  validation {
    condition     = length(var.s3_bucket_name) > 0
    error_message = "The s3_bucket_name value must not be empty."
  }
}

variable "s3_key_prefix" {
  description = "The prefix prepended to the AWSLogs/ path inside the log bucket. Must be set from the s3_key_prefix output of the aws_cloudtrail_s3_bucket module. If null, no prefix is used."
  type        = string
  nullable    = true
  default     = null
  validation {
    # A conditional instead of ||, which evaluates both operands before Terraform 1.12.
    condition     = var.s3_key_prefix == null ? true : length(var.s3_key_prefix) <= 200 && !can(regex("^/|/$|//", var.s3_key_prefix))
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
