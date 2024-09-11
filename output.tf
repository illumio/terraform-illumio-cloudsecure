output "onboarding_client_id" {
  value       = module.k8s_onboarding_credentials.client_id
  description = "The client_id to use to onboard k8s clusters."
}

output "onboarding_client_secret" {
  value       = module.k8s_onboarding_credentials.client_secret
  description = "The client_secret to use to onboard k8s clusters."
  sensitive   = true
}
