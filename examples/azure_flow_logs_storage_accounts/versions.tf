terraform {
  required_providers {
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = ">= 1.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}
