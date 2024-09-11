provider "illumio-cloudsecure" {
  client_id     = "my-client-id"
  client_secret = "my-secret-id"
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
  helm_release_name = var.helm_release_name
  chart             = var.helm_chart
  namespace         = var.helm_namespace
  helm_version      = var.helm_version
}

