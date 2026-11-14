output "id" {
  value       = illumio-cloudsecure_aws_cloudtrail_s3_bucket.this.id
  description = "The CloudSecure ID of the registered S3 bucket."
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.this.bucket
  description = "The name of the S3 bucket, to be used as the s3_bucket_name of the aws_cloudtrail module."

  # The trail must be created after the bucket policy, which CloudTrail checks at
  # creation, and only once the bucket is onboarded with CloudSecure.
  depends_on = [aws_s3_bucket_policy.this, illumio-cloudsecure_aws_cloudtrail_s3_bucket.this]
}

output "s3_key_prefix" {
  value       = var.s3_key_prefix
  description = "The prefix prepended to the AWSLogs/ path inside the bucket, to be used as the s3_key_prefix of the aws_cloudtrail module."

  # Same ordering as for s3_bucket_name, in case the trail only uses this output.
  depends_on = [aws_s3_bucket_policy.this, illumio-cloudsecure_aws_cloudtrail_s3_bucket.this]
}

output "trail_name" {
  value       = var.trail_name
  description = "The name of the CloudTrail trail allowed to write into the bucket, to be used as the name of the aws_cloudtrail module."

  # Same ordering as for s3_bucket_name, in case the trail only uses this output.
  depends_on = [aws_s3_bucket_policy.this, illumio-cloudsecure_aws_cloudtrail_s3_bucket.this]
}
