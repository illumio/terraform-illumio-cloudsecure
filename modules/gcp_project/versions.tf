terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.14.0"
    }
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = ">= 1.7.0"
    }
  }
}
