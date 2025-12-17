variable "iam_name_prefix" {
  description = "The prefix given to all GCP IAM resource names."
  type        = string
  default     = "illumio_cloud_integration"
  validation {
    condition     = length(var.iam_name_prefix) > 0
    error_message = "The iam_name_prefix value must not be empty."
  }
}

variable "illumio_service_account_email" {
  description = "The Illumio Service Account Email that will impersonate the created Service Account."
  type        = string
  default     = "illumio-onboarding@cs-prod-01.iam.gserviceaccount.com"
}

variable "mode" {
  description = "The account's access mode, must be \"ReadWrite\" (default) or \"Read\"."
  type        = string
  default     = "ReadWrite"
  validation {
    condition     = contains(["ReadWrite", "Read"], var.mode)
    error_message = "The mode value must be \"ReadWrite\" or \"Read\"."
  }
}

variable "name" {
  description = "The name of this project in CloudSecure."
  type        = string
  validation {
    condition     = length(var.name) > 0
    error_message = "The name must not be empty."
  }
}

variable "organization_id" {
  description = "The GCP Organization ID."
  type        = string
  validation {
    condition     = length(var.organization_id) > 0
    error_message = "The organization_id must not be empty."
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

