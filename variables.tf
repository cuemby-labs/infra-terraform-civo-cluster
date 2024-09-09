#
# Contextual Fields
#

variable "context" {
  description = <<-EOF
Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.

Examples:
```
context:
  project:
    name: string
    id: string
  environment:
    name: string
    id: string
  resource:
    name: string
    id: string
```
EOF
  type        = map(any)
  default     = {}
}

#
# Variables for Civo Kubernetes cluster
#

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "applications" {
  description = "Comma-separated list of applications to install"
  type        = string
  default     = "civo-cluster-autoscaler,helm"
}

variable "kubernetes_version" {
  description = "Version of Kubernetes to use"
  type        = string
  default     = "1.27.0"
}

variable "region" {
  description = "Civo region to deploy the cluster"
  type        = string
  default     = "NYC1"
}

variable "cluster_type" {
  description = "Type of cluster (e.g., talos, k3s)"
  type        = string
  default     = "talos"
  validation {
    condition     = contains(["talos", "k3s"], var.cluster_type)
    error_message = "Invalid cluster_type. Supported values are: talos, k3s."
  }
}

variable "cni" {
  description = "CNI plugin to use (e.g., flannel, cilium)"
  type        = string
  default     = "flannel"
  validation {
    condition = (
      (var.cluster_type == "talos" && var.cni == "flannel") ||
      (var.cluster_type == "k3s" && var.cni == "cilium")
    )
    error_message = "For 'talos' cluster_type, 'flannel' must be used as CNI. For 'k3s', 'cilium' must be used as CNI."
  }
}

variable "node_pool_label" {
  description = "Label for the node pool"
  type        = string
}

variable "node_size" {
  description = "Size of the nodes in the pool"
  type        = string
  default     = "g4s.kube.small"
}

variable "node_count" {
  description = "Number of nodes in the pool"
  type        = number
  default     = 3
}

#
# Variables for Civo network
#

variable "network_label" {
  description = "Label for the network"
  type        = string
}

variable "network_cidr_v4" {
  description = "CIDR block for the network"
  type        = string
  default     = "192.168.0.0/24"
}

variable "network_nameservers_v4" {
  description = "List of nameservers for the network"
  type        = list(string)
  default     = ["8.8.8.8", "1.1.1.1"]
}

#
# Variables for Civo firewall
#

variable "firewall_name" {
  description = "Name of the firewall rule set"
  type        = string
}

variable "external_network" {
  description = "external CIDR for kubectl access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "default_cidr" {
  description = "default CIDR 0.0.0.0/0"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "local_cidr" {
  description = "Local CIDR for ingress firewall rules"
  type        = list(string)
  default     = ["192.16.0.0/20"]
}
