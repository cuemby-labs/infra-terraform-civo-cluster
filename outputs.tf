#
# Cluster output
#

output "cluster_id" {
  description = "The ID of the Kubernetes cluster"
  value       = civo_kubernetes_cluster.this.id
}

output "network_id" {
  description = "The ID of the Civo network"
  value       = civo_network.this.id
}