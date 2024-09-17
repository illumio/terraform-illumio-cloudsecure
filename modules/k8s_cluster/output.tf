output "client_id" {
  value       = illumio-cloudsecure_k8s_cluster_onboarding_credential.this.client_id
  description = "The client_id that was used to onboard the k8s cluster, and may be used to onboard other clusters."
}

output "client_secret" {
  value       = illumio-cloudsecure_k8s_cluster_onboarding_credential.this.client_secret
  description = "The client_secret that was used to onboard the k8s cluster, and may be used to onboard other clusters."
  sensitive   = true
}