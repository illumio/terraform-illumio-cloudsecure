output "service_account_email" {
  value       = google_service_account.illumio_sa.email
  description = "The email of the created service account created for Illumio CloudSecure under the provided GCP Project ID."
  depends_on  = [illumio-cloudsecure_gcp_project.project]
}
