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
  source         = "github.com/illumio/terraform-illumio-cloudsecure//modules/k8s_cluster?ref=v1.3.0"
  illumio_region = "aws-us-west-2"
  name           = "example-release"
  description    = "Dev cluster in aws-us-west-2"
}