terraform {
  required_providers {
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = ">= 1.7.2"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 3.0.0"
    }
  }
}
