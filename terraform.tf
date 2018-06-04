variable "creds" {
    type    = "string"
    default = "creds.json"
}

variable "project" {
    type    = "string"
}

variable "region" {
    type    = "string"
}

variable "image" {
    type    = "string"
}

variable "type" {
    type    = "string"
}

variable "zone" {
    type    = "string"
}

variable "ssh_pub_file" {
    type    = "string"
}

variable "ssh_user" {
    type    = "string"
}

provider "google" {
    credentials = "${file(var.creds)}"
    project     = "${var.project}"
    region      = "${var.region}"
}

resource "google_compute_instance" "master" {
    name         = "k8s-master"
    machine_type = "${var.type}"
    zone         = "${var.zone}"

    metadata {
        sshKeys = "${var.ssh_user}:${file(var.ssh_pub_file)}"
    }

    boot_disk {
        initialize_params {
            image   = "${var.image}"
        }
    }

    network_interface {
        network = "default"
        access_config {
            // Ephemeral IP
        }
    }
}

output "ssh-master" {
    value = "ssh ${var.ssh_user}@${google_compute_instance.master.network_interface.0.access_config.0.assigned_nat_ip}"
}
