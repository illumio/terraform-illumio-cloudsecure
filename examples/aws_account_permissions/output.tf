output "role_arn" {
  value = module.aws_account_permissions.role_arn
}

output "external_id" {
  value     = module.aws_account_permissions.external_id
  sensitive = true
}