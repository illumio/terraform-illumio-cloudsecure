output "role_id" {
  value       = aws_iam_role.role.id
  description = "The ID of the IAM role granted to the CloudSecure account."
}