output "client_id" {
  value       = module.k8s_cluster.client_id
  description = "The client_id to use to onboard k8s clusters."
}

output "client_secret" {
  value       = module.k8s_cluster.client_secret
  description = "The client_secret to use to onboard k8s clusters."
  sensitive   = true
}