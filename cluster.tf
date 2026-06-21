locals {
  cp_machine_config_kind     = var.use_existing_machine_configs ? var.cp_machine_config_kind : rancher2_machine_config_v2.ranchmaster[0].kind
  cp_machine_config_name     = var.use_existing_machine_configs ? var.cp_machine_config_name : rancher2_machine_config_v2.ranchmaster[0].name
  worker_machine_config_kind = var.use_existing_machine_configs ? var.worker_machine_config_kind : rancher2_machine_config_v2.ranchworker[0].kind
  worker_machine_config_name = var.use_existing_machine_configs ? var.worker_machine_config_name : rancher2_machine_config_v2.ranchworker[0].name
}

resource "rancher2_cluster_v2" "rancher_cluster" {
  name                         = local.cluster_name_effective
  kubernetes_version           = var.rke2_version
  cloud_credential_secret_name = var.rancher_cloud_credential_name
  enable_network_policy        = false

  local_auth_endpoint {
    enabled = true
  }

  rke_config {
    machine_pools {
      name                         = "pool-masters"
      cloud_credential_secret_name = var.rancher_cloud_credential_name
      control_plane_role           = true
      etcd_role                    = true
      worker_role                  = false
      quantity                     = var.rancher_pool_numcps

      machine_config {
        api_version = var.machine_config_api_version
        kind        = local.cp_machine_config_kind
        name        = local.cp_machine_config_name
      }
    }

    machine_pools {
      name                         = "pool-workers"
      cloud_credential_secret_name = var.rancher_cloud_credential_name
      control_plane_role           = false
      etcd_role                    = false
      worker_role                  = true
      quantity                     = var.rancher_pool_numworkersmin

      machine_config {
        api_version = var.machine_config_api_version
        kind        = local.worker_machine_config_kind
        name        = local.worker_machine_config_name
      }

      annotations = {
        "cluster.provisioning.cattle.io/autoscaler-min-size" = var.rancher_pool_numworkersmin
        "cluster.provisioning.cattle.io/autoscaler-max-size" = var.rancher_pool_numworkersmax
      }
    }

    etcd {
      snapshot_retention = 60
    }

    machine_global_config = <<EOF
cni: "canal"
etcd-expose-metrics: true
EOF

    registries {
      mirrors {
        hostname  = "*"
        endpoints = [var.nexus_registry]
      }

      configs {
        hostname = var.nexus_registry
        insecure = true
      }
    }
  }

  annotations = {
    git_url      = var.git_url
    git_branch   = var.git_branch
    git_tag      = var.git_tag
    git_commitid = var.git_commitid
  }
}

resource "vault_mount" "k8sconfig" {
  path        = "secret/kubernetes/downstream/${terraform.workspace}"
  type        = "kv-v2"
  description = "Secret to hold downstream kubeconfig"
}

resource "rancher2_cluster_sync" "rancher_cluster" {
  cluster_id    = rancher2_cluster_v2.rancher_cluster.cluster_v1_id
  state_confirm = 60
}

resource "vault_generic_secret" "k8sconfig" {
  path = "${vault_mount.k8sconfig.path}/k8sconfig"

  data_json = jsonencode({
    data = base64encode(rancher2_cluster_sync.rancher_cluster.kube_config)
  })
}

resource "rancher2_token" "cluster_autoscaler_token" {
  description = "Cluster Autoscaler Token"
  ttl         = 0
}

resource "vault_generic_secret" "cluster_autoscaler_token" {
  path = "${vault_mount.k8sconfig.path}/token"

  data_json = jsonencode({
    token      = base64encode(rancher2_token.cluster_autoscaler_token.token)
    access_key = base64encode(rancher2_token.cluster_autoscaler_token.access_key)
    secret_key = base64encode(rancher2_token.cluster_autoscaler_token.secret_key)
    user_id    = base64encode(rancher2_token.cluster_autoscaler_token.user_id)
    id         = base64encode(rancher2_token.cluster_autoscaler_token.id)
  })
}

locals {
  k8s_host  = yamldecode(rancher2_cluster_sync.rancher_cluster.kube_config).clusters[0].cluster.server
  k8s_ca    = base64decode(yamldecode(rancher2_cluster_sync.rancher_cluster.kube_config).clusters[0].cluster["certificate-authority-data"])
  k8s_token = yamldecode(rancher2_cluster_sync.rancher_cluster.kube_config).users[0].user.token
}
