provider "minio" {
  minio_server   = local.rustfs_endpoint
  minio_user     = local.rustfs_access_key
  minio_password = local.rustfs_secret_key
  minio_region   = var.minio_region
  minio_ssl      = true
}

provider "routeros" {
  hosturl  = "https://mtrouter.domain.thedaily.tv"
  username = data.vault_generic_secret.mikrotik.data.user
  password = data.vault_generic_secret.mikrotik.data.pass
  insecure = true
}

provider "rancher2" {
  api_url   = data.vault_generic_secret.rancher_local.data["rancher-api-url"]
  token_key = data.vault_generic_secret.rancher_local.data["rancher-api-secret"]
  insecure  = true
  timeout   = "20m"
}
