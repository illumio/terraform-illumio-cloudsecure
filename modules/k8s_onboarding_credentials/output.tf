output "client_id" {
  value       = illumio-cloudsecure_k8s_cluster_onboarding_credential.this.client_id
  description = "The client_id to use to onboard k8s clusters."
}

output "client_secret" {
  value       = illumio-cloudsecure_k8s_cluster_onboarding_credential.this.client_secret
  description = "The client_secret to use to onboard k8s clusters."
  sensitive   = true
}
