variable "project_id" {
  description = "The ID of the GCP project that owns the storage buckets."
  type        = string
  validation {
    condition     = length(var.project_id) > 0
    error_message = "The project_id value must not be empty."
  }
}

variable "buckets" {
  description = "The set of existing Cloud Storage buckets receiving flow logs to register with CloudSecure by name and (optional) path prefix. No bucket is created unless create_bucket is true."
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
  description = "When true, create each Cloud Storage bucket. Defaults to false because customers usually already have a bucket receiving flow logs. Configuring flow log delivery to the bucket remains the caller's responsibility. bucket_location is required when this is true."
  type        = bool
  default     = false
}

variable "bucket_location" {
  description = "The location of the buckets created when create_bucket is true (e.g., US, EU, us-central1)."
  type        = string
  nullable    = true
  default     = null
  validation {
    condition     = !var.create_bucket || (var.bucket_location != null && var.bucket_location != "")
    error_message = "bucket_location must be set when create_bucket is true."
  }
}

variable "service_account_email" {
  description = "The email of the service account used by CloudSecure to read the buckets. When set, the module grants it roles/storage.objectViewer on each registered bucket. When null, granting CloudSecure read access is the caller's responsibility."
  type        = string
  nullable    = true
  default     = null
}

variable "labels" {
  description = "The optional labels added to every Cloud Storage bucket created when create_bucket is true."
  type        = map(string)
  default     = {}
}
