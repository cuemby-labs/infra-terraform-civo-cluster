#
# Cluster output
#

output "cluster_id" {
  description = "The ID of the Kubernetes cluster"
  value       = civo_kubernetes_cluster.this.id
}