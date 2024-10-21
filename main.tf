#
# Random number
#

resource "random_password" "random" {
  length  = 4
  special = false
  upper   = false
}

#
# Civo kubernetes cluster
#

locals {
  walrus_environment_name = try(local.context["environment"]["name"], null)
}

resource "civo_kubernetes_cluster" "this" {
    name               = "${var.cluster_name}-${local.walrus_environment_name}-${random_password.random.result}"
    applications       = var.applications
    network_id         = civo_network.this.id
    firewall_id        = civo_firewall.this.id

    kubernetes_version = var.kubernetes_version
    region             = var.region

    cluster_type       = var.cluster_type
    cni                = var.cni

    pools {
        label      = "${var.cluster_name}-node-${local.walrus_environment_name}-${random_password.random.result}"
        size       = var.node_size
        node_count = var.node_count
    }
}

#
# Civo network
#

resource "civo_network" "this" {
    label          = "${var.cluster_name}-network-${local.walrus_environment_name}-${random_password.random.result}"
    cidr_v4        = var.network_cidr_v4
    region         = var.region
    nameservers_v4 = var.network_nameservers_v4
}

#
# Civo firewall rules
#

resource "civo_firewall" "this" {
    name                 = "${var.cluster_name}-fw-${local.walrus_environment_name}-${random_password.random.result}"
    create_default_rules = false
    network_id           = civo_network.this.id
    region               = var.region

    egress_rule {
        action     = "allow"
        cidr       = var.default_cidr
        label      = "All UDP ports open"
        port_range = "1-65535"
        protocol   = "udp"
    }

    egress_rule {
        action     = "allow"
        cidr       = var.default_cidr
        label      = "All TCP ports open"
        port_range = "1-65535"
        protocol   = "tcp"
    }

    egress_rule {
        action     = "allow"
        cidr       = var.default_cidr
        label      = "Ping/traceroute"
        protocol   = "icmp"
    }

    ingress_rule {
        action     = "allow"
        cidr       = var.local_cidr
        label      = "All UDP ports open"
        port_range = "1-65535"
        protocol   = "udp"
    }

    ingress_rule {
        action     = "allow"
        cidr       = var.local_cidr
        label      = "All TCP ports open"
        port_range = "1-65535"
        protocol   = "tcp"
    }

    ingress_rule {
        action     = "allow"
        cidr       = var.local_cidr
        label      = "Ping/traceroute"
        protocol   = "icmp"
    }

    ingress_rule {
        action     = "allow"
        cidr       = var.external_network
        label      = "Kubectl access"
        port_range = "6443"
        protocol   = "tcp"
    }
}

#
# Walrus information
#

locals {
  context = var.context
}