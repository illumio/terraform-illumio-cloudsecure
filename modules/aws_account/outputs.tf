output "role_id" {
  value       = local.use_existing_role ? var.role_arn : aws_iam_role.role[0].id
  description = "The ID (or ARN, when role_arn is supplied) of the IAM role granted to the CloudSecure account."
}
