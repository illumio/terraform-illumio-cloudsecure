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

  values = [yamlencode({
    additionalLabels = var.additional_labels
    awsVpcCni = {
      autoModeNodeProxyLogCollection = {
        grantNodesProxy        = var.aws_vpc_cni_auto_mode_node_proxy_log_collection_grant_nodes_proxy
        maxConcurrentNodePolls = var.aws_vpc_cni_auto_mode_node_proxy_log_collection_max_concurrent_node_polls
        pollInterval           = var.aws_vpc_cni_auto_mode_node_proxy_log_collection_poll_interval
      }
    }
    cilium = {
      namespaces = var.cilium_namespaces
    }
    cluster = {
      name = var.cluster_name
    }
    clusterCredsSecret = {
      clientId = illumio-cloudsecure_k8s_cluster.this.client_id
    }
    env = {
      flowCache = {
        activeTimeout = var.flow_cache_active_timeout
        maxSize       = var.flow_cache_max_size
      }
      httpsProxy     = var.https_proxy
      statsLogPeriod = var.stats_log_period
    }
    openshift = {
      createAnyuidSccRoleBinding = var.openshift_create_anyuid_scc_role_binding
      ovnkNamespace              = var.openshift_ovnk_namespace
      workerNodeCidrs            = var.openshift_worker_node_cidrs
    }
  })]

  set_sensitive = [
    {
      name  = "clusterCredsSecret.clientSecret"
      value = illumio-cloudsecure_k8s_cluster.this.client_secret
    }
  ]
}
