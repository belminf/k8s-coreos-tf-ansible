variable "project" {
    type    = "string"
}

variable "ssh_pub_file" {
    type    = "string"
}

variable "knode_count" {
    type    = "string"
    default = 2
}

variable "creds" {
    type    = "string"
    default = "creds.json"
}

variable "image_project" {
    type    = "string"
    default = "coreos-cloud"
}

variable "image_family" {
    type    = "string"
    default = "coreos-stable"
}

variable "type" {
    type    = "string"
    default = "n1-standard-1"
}

variable "zone" {
    type    = "string"
    default = "us-east1-b"
}


variable "ssh_user" {
    type    = "string"
    default = "core"
}


provider "google" {
    credentials = "${file(var.creds)}"
    project     = "${var.project}"
}

resource "google_compute_instance" "master" {
    name            = "k8s-master"
    tags            = ["kubernetes"]

    machine_type    = "${var.type}"
    zone            = "${var.zone}"
    can_ip_forward  = true

    metadata {
        sshKeys = "${var.ssh_user}:${file(var.ssh_pub_file)}"
    }

    boot_disk {
        initialize_params {
            image   = "${var.image_project}/${var.image_family}"
        }
    }

    network_interface {
        network = "default"
        access_config {
            // Ephemeral IP
        }
    }
}

resource "google_compute_instance" "knodes" {
    name            = "k8s-node${format("%02d", count.index + 1)}"
    count           = "${var.knode_count}"
    tags            = ["kubernetes"]

    machine_type    = "${var.type}"
    zone            = "${var.zone}"
    can_ip_forward  = true


    metadata {
        sshKeys = "${var.ssh_user}:${file(var.ssh_pub_file)}"
    }

    boot_disk {
        initialize_params {
            image   = "${var.image_project}/${var.image_family}"
        }
    }

    network_interface {
        network = "default"
        access_config {
            // Ephemeral IP
        }
    }
}

resource "google_compute_firewall" "kubernetes" {
    name        = "kubernetes-api"
    network     = "default"
    
    allow {
        protocol    = "tcp"
        ports       = ["8443"]
    }

    target_tags = ["kubernetes"]
}

output "ssh-master" {
    value = "ssh ${var.ssh_user}@${google_compute_instance.master.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "nodes" {
    value = "${join(",", google_compute_instance.knodes.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}
