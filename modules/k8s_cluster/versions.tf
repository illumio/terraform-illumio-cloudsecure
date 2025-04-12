terraform {
  required_providers {
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = ">= 1.4.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.15"
    }
  }
}
