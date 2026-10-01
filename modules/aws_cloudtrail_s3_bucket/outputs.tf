output "cloudsecure_id" {
  value       = illumio-cloudsecure_aws_cloudtrail_s3_bucket.this.id
  description = "The CloudSecure ID of the registered S3 bucket."
}

output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "The ARN of the S3 bucket."
}

output "bucket_name" {
  value       = aws_s3_bucket.this.id
  description = "The name of the S3 bucket."
}

output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.this.bucket_regional_domain_name
  description = "The regional domain name of the S3 bucket."
}

output "log_prefix" {
  value       = local.log_prefix
  description = "The key prefix the log files are written under, empty when no prefix is used."
}

output "policy_json" {
  value       = data.aws_iam_policy_document.this.json
  description = "The bucket policy rendered by this module."
}
