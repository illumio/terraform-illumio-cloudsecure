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
      name  = "awsVpcCni.autoModeNodeProxyLogCollection.grantNodesProxy"
      value = var.aws_vpc_cni_auto_mode_node_proxy_log_collection_grant_nodes_proxy
    },
    {
      name  = "awsVpcCni.autoModeNodeProxyLogCollection.maxConcurrentNodePolls"
      value = var.aws_vpc_cni_auto_mode_node_proxy_log_collection_max_concurrent_node_polls
    },
    {
      name  = "awsVpcCni.autoModeNodeProxyLogCollection.pollInterval"
      value = var.aws_vpc_cni_auto_mode_node_proxy_log_collection_poll_interval
    },
    {
      name  = "cluster.name"
      value = var.cluster_name
    },
    {
      name  = "clusterCredsSecret.clientId"
      value = illumio-cloudsecure_k8s_cluster.this.client_id
    },
    {
      name  = "env.flowCache.activeTimeout"
      value = var.flow_cache_active_timeout
    },
    {
      name  = "env.flowCache.maxSize"
      value = var.flow_cache_max_size
    },
    {
      name  = "env.httpsProxy"
      value = var.https_proxy
    },
    {
      name  = "env.statsLogPeriod"
      value = var.stats_log_period
    },
    {
      name  = "openshift.createAnyuidSccRoleBinding"
      value = var.openshift_create_anyuid_scc_role_binding
    },
    {
      name  = "openshift.ovnkNamespace"
      value = var.openshift_ovnk_namespace
    }
  ]

  dynamic "set" {
    for_each = var.additional_labels
    content {
      name  = "additionalLabels.${set.key}"
      value = set.value
    }
  }

  set_sensitive = [
    {
      name  = "clusterCredsSecret.clientSecret"
      value = illumio-cloudsecure_k8s_cluster.this.client_secret
    }
  ]

  set_list = flatten([
    length(var.cilium_namespaces) > 0 ? [
      {
        name  = "cilium.namespaces"
        value = var.cilium_namespaces
      }
    ] : [],
    length(var.openshift_worker_node_cidrs) > 0 ? [
      {
        name  = "openshift.workerNodeCidrs"
        value = var.openshift_worker_node_cidrs
      }
    ] : []
  ])
}
