output "service_principal_client_id" {
  value       = local.service_principal_object_id
  description = "The object ID of the service principal used for Illumio CloudSecure (either the newly created one or the pre-existing one looked up via existing_client_id)."
}

output "iam_name_prefix" {
  value       = var.iam_name_prefix
  description = "The prefix given to all Azure resource names."
}

output "mode" {
  value       = var.mode
  description = "The account's access mode, must be \"ReadWrite\" (default) or \"Read\"."
}

output "azure_secret_expiration_days" {
  value       = var.azure_secret_expiration_days
  description = "The number of days the Azure service principal secret remains valid before requiring renewal."
}