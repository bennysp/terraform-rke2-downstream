resource "rancher2_catalog_v2" "bitnami" {
  cluster_id = rancher2_cluster_sync.rancher_cluster.id
  name       = "bitnami"
  url        = "https://charts.bitnami.com/bitnami"

  timeouts {
    create = "20m"
    delete = "20m"
  }
}

resource "rancher2_secret_v2" "ghpersonal" {
  cluster_id = rancher2_cluster_sync.rancher_cluster.id
  name       = "github-auth"
  namespace  = "cattle-system"
  type       = "kubernetes.io/basic-auth"

  data = {
    password = data.vault_generic_secret.github.data.token
    username = data.vault_generic_secret.github.data.user
  }
}

resource "rancher2_catalog_v2" "home" {
  cluster_id       = rancher2_cluster_sync.rancher_cluster.id
  name             = "home"
  git_repo         = "https://github.com/bennysp/rancher-contdelivery.git"
  git_branch       = "main"
  secret_name      = rancher2_secret_v2.ghpersonal.name
  secret_namespace = rancher2_secret_v2.ghpersonal.namespace

  timeouts {
    create = "20m"
    delete = "20m"
  }
}

resource "rancher2_catalog_v2" "external_secrets" {
  cluster_id = rancher2_cluster_sync.rancher_cluster.id
  name       = "external-secrets"
  url        = "https://charts.external-secrets.io"

  timeouts {
    create = "20m"
    delete = "20m"
  }
}
