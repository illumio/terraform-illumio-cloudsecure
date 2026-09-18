output "role_id" {
  value       = local.use_existing_role ? var.role_arn : aws_iam_role.role[0].id
  description = "The ID (or ARN, when role_arn is supplied) of the IAM role granted to the CloudSecure account."
}

output "cloudtrail_arn" {
  value       = var.create_cloudtrail ? aws_cloudtrail.this[0].arn : null
  description = "The ARN of the CloudTrail trail created by this module, or null when create_cloudtrail is false."
}
