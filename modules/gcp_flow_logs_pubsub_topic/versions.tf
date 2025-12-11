terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      # TODO: need to update version after provider release
      version = ">= 1.6.1"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.12"
    }
  }
}
