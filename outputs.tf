output "rancher_cluster_name" {
  value = rancher2_cluster_v2.rancher_cluster.name
}

output "ranchermasterips" {
  value = [for h in rancher2_cluster_sync.rancher_cluster.nodes : h.ip_address if contains(h.roles, "control_plane")]
}

output "kubeconfig_location" {
  value = var.kubeconfig_path
}

output "k8s_host" {
  value     = local.k8s_host
  sensitive = true
}

output "k8s_token" {
  value     = local.k8s_token
  sensitive = true
}

output "k8s_ca" {
  value     = local.k8s_ca
  sensitive = true
}

output "k8s_config" {
  value = nonsensitive(rancher2_cluster_sync.rancher_cluster.kube_config)
}

output "summary" {
  value = {
    cluster_name    = local.cluster_name_effective
    rke2_version    = var.rke2_version
    endpoint_dns    = var.endpoint_dns
    kubeconfig_path = var.kubeconfig_path
  }
}
