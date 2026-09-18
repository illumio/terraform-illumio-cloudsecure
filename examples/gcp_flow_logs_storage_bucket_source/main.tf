provider "google" {
  project = "my-project-id"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "gcp_project_dev" {
  source  = "illumio/cloudsecure/illumio//modules/gcp_project"
  version = "1.7.0"

  project_id      = "my-project-id"
  organization_id = "123456789012"
  name            = "Example GCP Project"
  mode            = "ReadWrite"
}

module "gcp_flow_logs_storage_bucket_source" {
  source  = "illumio/cloudsecure/illumio//modules/gcp_flow_logs_storage_bucket_source"
  version = "1.7.0"

  project_id = "my-project-id"

  # Grant the onboarded project's service account read access to the buckets.
  service_account_email = module.gcp_project_dev.service_account_email

  # Register existing customer buckets by name and optional prefix. These already
  # receive flow logs; no bucket is created (create_bucket defaults to false).
  buckets = [
    { bucket_name = "flows-bucket-1" },
    { bucket_name = "flows-bucket-2", path_prefix = "custom-path/first" },
  ]
}
