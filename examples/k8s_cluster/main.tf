provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # Adjust this path as needed
  }
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "k8s_cluster_dev" {
  source           = "illumio/cloudsecure/illumio//modules/k8s_cluster"
  version          = "1.5.0"
  illumio_region   = "aws-us-west-2"
  name             = "example-release"

  # Optional attributes
  create_operator_namespace = true
  enable_falco              = false
  operator_namespace        = "illumio-cloud"
  operator_version          = "v1.1.2"
}
