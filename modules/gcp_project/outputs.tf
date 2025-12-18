output "service_account_email" {
  value       = google_service_account.illumio_sa.email
  description = "The email of the Service Account created for Illumio CloudSecure under the GCP Project."
  depends_on  = [illumio-cloudsecure_gcp_project.project]
}
