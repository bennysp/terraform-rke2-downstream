provider "minio" {
  minio_server     = var.minio_server
  minio_user       = var.MINIO_ACCESS_KEY
  minio_password   = var.MINIO_SECRET_KEY
  minio_region     = var.minio_region
  minio_ssl        = true
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
