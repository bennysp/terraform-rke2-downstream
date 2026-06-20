resource "routeros_ip_dns_record" "name_record" {
  name    = var.endpoint_dns
  address = rancher2_cluster_sync.rancher_cluster.nodes[0].ip_address
  ttl     = 1
  type    = "A"
}
