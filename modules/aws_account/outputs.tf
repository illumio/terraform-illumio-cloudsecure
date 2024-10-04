output "role_arn" {
  value       = aws_iam_role.role.arn
  description = "The ARN of the IAM role granted to the CloudSecure account."
}

output "role_name" {
  value       = aws_iam_role.role.name
  description = "The name of the IAM role granted to the CloudSecure account."
}