output "project_role_id" {
  value       = google_project_iam_custom_role.pubsub_access_role.id
  description = "The ID of the custom IAM role created for Pub/Sub subscription management."
}

output "topic_role_id" {
  value       = google_project_iam_custom_role.flow_access_role.id
  description = "The ID of the custom IAM role created for attaching subscriptions to GCP Pub/Sub topics."
}
