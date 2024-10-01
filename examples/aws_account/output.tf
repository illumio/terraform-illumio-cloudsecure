output "role_arn" {
  value = module.aws_account_permissions.role_arn
  description = "The ARN of the IAM role granted to the CloudSecure account."
}