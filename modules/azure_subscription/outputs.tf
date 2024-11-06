output "service_principal_id" {
  value       = azuread_service_principal.illumio_sp.object_id
  description = "The ID of the service principal created for Illumio CloudSecure."
}

output "iam_name_prefix" {
  value       = var.iam_name_prefix
  description = "The prefix given to all Azure resource names."
}

output "mode" {
  value       = var.mode
  description = "The account's access mode, must be \"ReadWrite\" (default) or \"Read\"."
}

output "secret_expiration_days" {
  value       = var.azure_secret_expiration_days
  description = "The number of days the Azure service principal secret remains valid before requiring renewal."
}