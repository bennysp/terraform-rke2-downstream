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

data "vault_generic_secret" "root_ca" {
  path = var.vault_ca_path
}
