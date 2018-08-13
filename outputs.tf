output "k8sserver-ip" {
  value = ["https://${hcloud_server.k8sserver.ipv4_address}"]
}
