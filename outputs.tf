output "k8sserver-ip" {
  value = ["${digitalocean_droplet.k8sserver.ipv4_address}"]
}
