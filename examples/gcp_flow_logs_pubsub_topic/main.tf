provider "google" {
  project = "my-project-id"
}

provider "illumio-cloudsecure" {
  client_secret = var.illumio_cloudsecure_client_secret
  client_id     = var.illumio_cloudsecure_client_id
}

module "gcp_project_dev" {
  source  = "illumio/cloudsecure/illumio//modules/gcp_project"
  version = "1.6.3"

  project_id      = "my-project-id"
  organization_id = "123456789012"
  name            = "Example GCP Project"
  mode            = "ReadWrite"
}

module "gcp_flow_logs_pubsub_topic_dev" {
  source  = "illumio/cloudsecure/illumio//modules/gcp_flow_logs_pubsub_topic"
  version = "1.6.3"

  project_id            = "my-project-id"
  service_account_email = module.gcp_project_dev.service_account_email
  pubsub_topic_ids      = [
    "projects/my-project/topics/vpc-flow-logs-topic-1",
    "projects/my-project/topics/vpc-flow-logs-topic-2"
  ]
}
