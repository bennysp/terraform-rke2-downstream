provider "aws" {
  access_key = local.rustfs_access_key
  secret_key = local.rustfs_secret_key
  region     = var.s3_region

  skip_credentials_validation = true
  skip_region_validation      = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    s3 = local.rustfs_url
  }
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
