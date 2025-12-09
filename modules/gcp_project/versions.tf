terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = ">= 1.6.1"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.12"
    }
  }
}
