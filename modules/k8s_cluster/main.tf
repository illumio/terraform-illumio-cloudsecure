resource "illumio-cloudsecure_k8s_cluster" "this" {
  illumio_region = var.illumio_region
  log_level      = var.log_level
}

resource "helm_release" "helm_cloud_operator" {
  name             = var.name
  version          = var.operator_version
  chart            = "oci://ghcr.io/illumio/charts/cloud-operator"
  namespace        = var.operator_namespace
  create_namespace = var.create_operator_namespace

  set = [
    {
      name  = "clusterCredsSecret.clientId"
      value = illumio-cloudsecure_k8s_cluster.this.client_id
    },
    set {
      name  = "clusterCredsSecret.clientSecret"
      value = illumio-cloudsecure_k8s_cluster.this.client_secret
    },
    set {
      name  = "falco.enabled"
      value = var.enable_falco
    },
    set {
      name  = "env.httpsProxy"
      value = var.https_proxy
    }
  ]
}
