locals {
  cluster_name_effective = trimspace(var.cluster_name) != "" ? var.cluster_name : var.rancher_cluster_name
}
