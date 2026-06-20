terraform {
  required_version = ">= 1.6.0"

  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "~> 2.2"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "~> 7.2"
    }
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "~> 1.37"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.10"
    }
  }
}
