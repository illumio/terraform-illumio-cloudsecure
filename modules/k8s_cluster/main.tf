resource "illumio-cloudsecure_k8s_cluster_onboarding_credential" "this" {
  illumio_region = var.illumio_region
  name           = var.name
  description    = var.description
}

resource "helm_release" "helm_cloud_operator" {
  name             = var.name
  version          = var.version
  chart            = "oci://ghcr.io/illumio/charts/cloud-operator"
  namespace        = var.namespace
  create_namespace = var.create_namespace

  set {
    name  = "onboardingSecret.clientId"
    value = illumio-cloudsecure_k8s_cluster_onboarding_credential.this.client_id
  }

  set {
    name  = "onboardingSecret.clientSecret"
    value = illumio-cloudsecure_k8s_cluster_onboarding_credential.this.client_secret
  }
}
