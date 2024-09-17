provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Adjust this path as needed
  }
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "k8s_cluster" {
  source            = "../../modules/k8s_cluster"
  illumio_region    = var.illumio_region
  name              = var.name
  description       = var.description
}