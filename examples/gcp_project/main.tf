provider "google" {
  project = "my-project-id"
}

provider "illumio-cloudsecure" {
  client_secret = var.illumio_cloudsecure_client_secret
  client_id     = var.illumio_cloudsecure_client_id
}

module "gcp_project_dev" {
  source  = "illumio/cloudsecure/illumio//modules/gcp_project"
  version = "1.6.8"
  name            = "Example GCP Project"
  organization_id = "123456789012"
  project_id      = "my-project-id"

  # Optional attributes
  iam_name_prefix = "illumio_cloud_integration"
  mode            = "ReadWrite"  
}
