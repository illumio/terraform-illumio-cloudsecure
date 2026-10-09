output "cloudsecure_id" {
  value       = one(module.log_bucket[*].cloudsecure_id)
  description = "The CloudSecure ID of the registered log bucket, null when the bucket is not managed by this module."
}

output "log_prefix" {
  value       = local.log_prefix
  description = "The key prefix the log files are written under, empty when no prefix is used."
}

output "s3_bucket_arn" {
  value       = one(module.log_bucket[*].bucket_arn)
  description = "The ARN of the log bucket, null when the bucket is not managed by this module."
}

output "s3_bucket_name" {
  value       = var.create_s3_bucket ? one(module.log_bucket[*].bucket_name) : var.s3_bucket_name
  description = "The name of the log bucket."
}

output "trail_arn" {
  value       = aws_cloudtrail.this.arn
  description = "The ARN of the trail."
}

output "trail_home_region" {
  value       = aws_cloudtrail.this.home_region
  description = "The home Region of the trail."
}

output "trail_id" {
  value       = aws_cloudtrail.this.id
  description = "The ID of the trail."
}

output "trail_name" {
  value       = aws_cloudtrail.this.name
  description = "The name of the trail."
}
