terraform {
  required_providers {
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = "~> 1.0.9"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~>2.15.0"
    }
  }
}
