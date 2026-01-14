provider "google" {
  project = "my-project-id"
}

provider "illumio-cloudsecure" {
  client_secret = var.illumio_cloudsecure_client_secret
  client_id     = var.illumio_cloudsecure_client_id
}

module "gcp_project_dev" {
  source  = "illumio/cloudsecure/illumio//modules/gcp_project"
  version = "1.6.2"

  project_id      = "my-project-id"
  organization_id = "123456789012"
  name            = "Example GCP Project"
  mode            = "ReadWrite"
  
  tags            = {
    "Environment" = "Dev"
    "Owner"       = "John Doe"
  }
}
