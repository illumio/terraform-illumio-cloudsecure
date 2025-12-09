variable "project_id" {
  description = "The GCP Project ID."
  type        = string
  validation {
    condition     = length(var.project_id) > 0
    error_message = "The project_id must not be empty."
  }
}

variable "service_account_email" {
  description = "The email of the service account to grant permissions to."
  type        = string
  validation {
    condition     = length(var.service_account_email) > 0
    error_message = "The service_account_email must not be empty."
  }
}

variable "pubsub_topics" {
  description = "A set of Pub/Sub topic URIs (e.g., //pubsub.googleapis.com/projects/myproject/topics/mytopic)."
  type        = set(string)
  validation {
    condition     = length(var.pubsub_topics) > 0
    error_message = "The pubsub_topics set must not be empty."
  }
}
