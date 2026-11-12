provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config" # Adjust this path as needed
  }
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "k8s_cluster_dev" {
  source           = "illumio/cloudsecure/illumio//modules/k8s_cluster"
  version          = "1.7.1"
  illumio_region   = "aws-us-west-2"
  name             = "example-release"

  # Optional attributes
  additional_labels                                                         = {env = "Prod"}
  aws_vpc_cni_auto_mode_node_proxy_log_collection_grant_nodes_proxy         = true
  aws_vpc_cni_auto_mode_node_proxy_log_collection_max_concurrent_node_polls = 10
  aws_vpc_cni_auto_mode_node_proxy_log_collection_poll_interval             = "10s"
  cilium_namespaces                                                         = ["kube-system", "gke-managed-dpv2-observability", "cilium"]
  cluster_name                                                              = "test-cluster-12"
  create_operator_namespace                                                 = true
  flow_cache_active_timeout                                                 = "20s"
  flow_cache_max_size                                                       = 1000
  https_proxy                                                               = "http://proxy.example.com:8080"
  log_level                                                                 = "Info"
  openshift_create_anyuid_scc_role_binding                                  = true
  openshift_ovnk_namespace                                                  = "openshift-ovn-kubernetes"
  openshift_worker_node_cidrs                                               = ["10.4.0.0/16"]
  operator_namespace                                                        = "illumio-cloud"
  operator_version                                                          = "v1.6.0"
  stats_log_period                                                          = "30m"
}
