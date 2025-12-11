provider "google" {
  project = var.gcp_project_id
}

provider "illumio-cloudsecure" {
  client_secret = var.illumio_cloudsecure_client_secret
  client_id     = var.illumio_cloudsecure_client_id
}

module "gcp_project_dev" {
  source = "illumio/cloudsecure/illumio//modules/gcp_project"
  version = "1.6.1" # TODO: update after provider release

  project_id      = var.gcp_project_id
  organization_id = var.gcp_org_id
  name            = "Example GCP Project"
  mode            = "ReadWrite"
}

module "gcp_flow_logs_pubsub_topic_dev" {
  source = "illumio/cloudsecure/illumio//modules/gcp_flow_logs_pubsub_topic"
  version = "1.6.1" # TODO: update after provider release

  project_id            = var.gcp_project_id
  service_account_email = module.gcp_project_dev.service_account_email
  pubsub_topics         = [
    "//pubsub.googleapis.com/projects/my-project/topics/vpc-flow-logs-topic-1",
    "//pubsub.googleapis.com/projects/my-project/topics/vpc-flow-logs-topic-2"
  ]
}
