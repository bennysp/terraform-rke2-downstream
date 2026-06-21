terraform {
  required_version = ">= 1.6.0"

  required_providers {
    minio = {
      source  = "nexus.ta.domain.thedaily.tv/aminueza/minio"
      version = "~> 2.2"
    }
    rancher2 = {
      source  = "nexus.ta.domain.thedaily.tv/rancher/rancher2"
      version = "~> 7.2"
    }
    routeros = {
      source  = "nexus.ta.domain.thedaily.tv/terraform-routeros/routeros"
      version = "~> 1.37"
    }
    vault = {
      source  = "nexus.ta.domain.thedaily.tv/hashicorp/vault"
      version = "~> 3.10"
    }
  }
}
