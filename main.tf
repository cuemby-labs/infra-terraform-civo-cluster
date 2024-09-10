locals {
  context = var.context
}

module "submodule" {
  source = "./modules/submodule"

  message = "Hello, submodule"
}

#
# Civo kubernetes cluster
#

resource "civo_kubernetes_cluster" "this" {
    name               = var.cluster_name
    applications       = var.applications
    network_id         = civo_network.this.id
    firewall_id        = civo_firewall.this.id

    kubernetes_version = var.kubernetes_version
    region             = var.region

    cluster_type       = var.cluster_type
    cni                = var.cni

    pools {
        label      = var.node_pool_label
        size       = var.node_size
        node_count = var.node_count
    }
}

#
# Civo network
#

data "civo_network" "existing" {
  label  = var.network_label
  region = var.region
}

resource "civo_network" "this" {
    count = length(data.civo_network.existing) == 0 ? 1 : 0

    label          = var.network_label
    cidr_v4        = var.network_cidr_v4
    region         = var.region
    nameservers_v4 = var.network_nameservers_v4
}

#
# Civo firewall rules
#

data "civo_firewall" "existing" {
  name   = var.firewall_name
  region = var.region
}

resource "civo_firewall" "this" {
    count = length(data.civo_firewall.existing) == 0 ? 1 : 0

    name                 = var.firewall_name
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