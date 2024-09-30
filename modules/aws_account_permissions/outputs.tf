output "role_arn" {
  value = aws_iam_role.illumio_cloud_integration_role.arn
}

output "external_id" {
  value = random_uuid.role_secret.result
  sensitive = true
}