# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

variable "do_token" {
  default = "xxx"
}

variable "prefix" {
  default = "yourname"
}


variable "count_k8s_all_nodes" {
  default = "3"
}

variable "count_k8s_etcd_nodes" {
  default = "0"
}

variable "count_k8s_controlplane_nodes" {
  default = "0"
}

variable "count_k8s_worker_nodes" {
  default = "0"
}


variable "cluster_name" {
  default = "custom"
}

variable "region" {
  default = "ams3"
}

variable "size" {
  default = "s-2vcpu-4gb"
}

variable "docker_version_server" {
  default = "17.03"
}

variable "docker_version_worker" {
  default = "17.03"
}

variable "ssh_keys" {
  default = []
}