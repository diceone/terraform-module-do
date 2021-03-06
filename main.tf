resource "digitalocean_droplet" "k8sserver" {
  count     = "1"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-k8sserver"
  region    = "${var.region}"
  size      = "${var.size}"
  user_data = "${data.template_file.userdata_server.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "k8s-all" {
  count     = "${var.count_k8s_worker_all_nodes}"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-worker-${count.index}-all"
  region    = "${var.region}"
  size      = "${var.size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "k8s-etcd" {
  count     = "${var.count_k8s_etcd_nodes}"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-worker-${count.index}-etcd"
  region    = "${var.region}"
  size      = "${var.size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "k8s-controlplane" {
  count     = "${var.count_k8s_controlplane_nodes}"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-worker-${count.index}-controlplane"
  region    = "${var.region}"
  size      = "${var.size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "k8s-worker" {
  count     = "${var.count_k8s_worker_nodes}"
  image     = "ubuntu-16-04-x64"
  name      = "${var.prefix}-worker-${count.index}-worker"
  region    = "${var.region}"
  size      = "${var.size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

data "template_file" "userdata_server" {
  template = "${file("${path.module}/files/userdata_server")}"

  vars {
    cluster_name          = "${var.cluster_name}"
    docker_version_server = "${var.docker_version_server}"
  }
}

data "template_file" "userdata_agent" {
  template = "${file("${path.module}/files/userdata_agent")}"

  vars {
    cluster_name          = "${var.cluster_name}"
    docker_version_worker = "${var.docker_version_worker}"
    server_address        = "${digitalocean_droplet.k8sserver.ipv4_address}"
  }
}