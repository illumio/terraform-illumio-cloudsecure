output "source_ids" {
  description = "Map of bucket key (\"<bucket_name>\" or \"<bucket_name>::<path_prefix>\") to the CloudSecure flow logs S3 bucket source ID."
  value       = { for k, source in illumio-cloudsecure_aws_flow_logs_s3_bucket_source.this : k => source.id }
}

output "bucket_names" {
  description = "The set of registered S3 bucket names."
  value       = [for b in var.buckets : b.bucket_name]
}
