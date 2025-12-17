variable "iam_name_prefix" {
  description = "The prefix given to all GCP IAM resource names."
  type        = string
  default     = "IllumioCloudIntegration"
  validation {
    condition     = length(var.iam_name_prefix) > 0
    error_message = "The iam_name_prefix value must not be empty."
  }
}

variable "project_id" {
  description = "The GCP Project ID."
  type        = string
  validation {
    condition     = length(var.project_id) > 0
    error_message = "The project_id value must not be empty."
  }
}

variable "pubsub_topic_ids" {
  description = "The set of resource IDs of the GCP Pub/Sub topics containing flow logs, in the format projects/<project>/topics/<topic>."
  type        = set(string)
  validation {
    condition     = length(var.pubsub_topic_ids) > 0
    error_message = "The pubsub_topic_ids value must not be empty."
  }
}

variable "service_account_email" {
  description = "The email of the service account to grant permissions to."
  type        = string
  validation {
    condition     = length(var.service_account_email) > 0
    error_message = "The service_account_email value must not be empty."
  }
}
