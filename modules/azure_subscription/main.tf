terraform {
  required_providers {
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = "~> 1.1.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.4.0"
    }
  }
}


resource "illumio-cloudsecure_azure_subscription" "subscription" {
  client_id     = ""
    client_secret = ""
    mode = ""
    tenant_id     = "" 
}