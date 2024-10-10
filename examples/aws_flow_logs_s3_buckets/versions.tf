terraform {
  required_providers {
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = "~> 1.0.11"
    }
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}
