variable "ssh_key_id" {
    type = "string"
}

variable "do_token" {
    type = "string"
}

variable "region" {
    type = "string"
}

variable "size" {
    type = "string"
}

provider "digitalocean" {
    token = "${var.do_token}"
}

resource "digitalocean_droplet" "master" {
  count = "1"
  name = "k8-coreos"
  private_networking = true
  image = "coreos-stable"
  size = "${var.size}"
  region = "${var.region}"
  ssh_keys = ["${var.ssh_key_id}"]
}

output "ssh-master" {
    value = "ssh core@${digitalocean_droplet.master.ipv4_address}"
}
