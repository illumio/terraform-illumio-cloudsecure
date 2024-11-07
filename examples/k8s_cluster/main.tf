provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Adjust this path as needed
  }
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "k8s_cluster_dev" {
  source         = "illumio/cloudsecure/illumio//modules/k8s_cluster"
  version        = "1.3.1"
  illumio_region = "aws-us-west-2"
  name           = "example-release"
  description    = "Dev cluster in aws-us-west-2"
}