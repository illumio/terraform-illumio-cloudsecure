terraform {
  required_providers {
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = "~> 1.0.9"
    }
  }
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
  # For testing dev
  api_endpoint   = "dns:///dev.cloud.ilabs.io:443"
  token_endpoint = "https://dev.cloud.ilabs.io/api/v1/authenticate"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # Adjust this path as needed
  }
}


module "k8s_onboarding_credentials" {
  source            = "./modules/k8s_onboarding_credentials"
  illumio_region    = var.illumio_region
  name              = var.name
  description       = var.description
  helm_release_name = "illumio"
  helm_chart        = "cloud-operator-chart"
  helm_namespace    = "illumio-cloud"
  create_namespace  = true
  helm_version      = var.helm_version
}

