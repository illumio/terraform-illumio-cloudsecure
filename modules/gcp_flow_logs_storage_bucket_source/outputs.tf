output "source_ids" {
  description = "Map of bucket key (\"<bucket_name>\" or \"<bucket_name>::<path_prefix>\") to the CloudSecure flow logs storage bucket source ID."
  value       = { for k, source in illumio-cloudsecure_gcp_flow_logs_storage_bucket_source.this : k => source.id }
}

output "bucket_names" {
  description = "The set of registered Cloud Storage bucket names."
  value       = [for b in var.buckets : b.bucket_name]
}
