data "vault_generic_secret" "vsphere" {
  path = var.vaultpath_vsphere
}

data "vault_generic_secret" "linux" {
  path = var.vaultpath_linux
}

data "vault_generic_secret" "github" {
  path = var.vaultpath_github
}

data "vault_generic_secret" "mikrotik" {
  path = var.vaultpath_mikrotik
}

data "vault_generic_secret" "rancher_local" {
  path = var.vaultpath_rancher_local
}

data "vault_generic_secret" "rustfs_api" {
  path = var.vaultpath_rustfs_api
}

data "vault_generic_secret" "root_ca" {
  path = var.vault_ca_path
}

locals {
  rustfs_url        = trimspace(data.vault_generic_secret.rustfs_api.data["url"])
  rustfs_endpoint   = trimsuffix(trimprefix(trimprefix(local.rustfs_url, "https://"), "http://"), "/")
  rustfs_access_key = trimspace(data.vault_generic_secret.rustfs_api.data["ACCESS_KEY"])
  rustfs_secret_key = trimspace(data.vault_generic_secret.rustfs_api.data["SECRET_KEY"])
}
