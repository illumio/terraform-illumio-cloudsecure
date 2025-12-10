output "service_account_email" {
  value       = google_service_account.illumio_sa.email
  description = "The email of the created service account created for Illumio CloudSecure under the provided GCP Project ID."
  depends_on  = [illumio-cloudsecure_gcp_project.project]
}

output "mode" {
  value       = var.mode
  description = "The account's access mode, must be \"ReadWrite\" (default) or \"Read\"."
}
