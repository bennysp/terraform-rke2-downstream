terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "nexus.ta.domain.thedaily.tv/hashicorp/aws"
      version = "~> 5.0"
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
