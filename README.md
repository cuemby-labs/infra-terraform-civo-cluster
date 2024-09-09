# Civo Cluster Template

Terraform module which deploys Civo kubernetes cluster on CIVO provider.

## Usage

```hcl
module "civo_k8s_cluster" {
  source = "./modules/civo-k8s-cluster"

  cluster_name           = "civo-cluster"
  network_label          = "civo-network"
  firewall_name          = "civo-fw-rule"
  node_pool_label        = "civo-node-pool"
  network_cidr_v4        = "192.168.0.0/24"
  network_nameservers_v4 = ["8.8.8.8", "1.1.1.1"]
  kubernetes_version     = "1.27.0"
  region                 = "NYC1"
  cluster_type           = "talos"
  cni                    = "flannel"
  node_size              = "g4s.kube.small"
  node_count             = 3
  local_cidr             = ["192.168.0.0/24"]
  external_network       = ["0.0.0.0/0"]
  default_cidr           = ["0.0.0.0/0"]
}
```

## Examples

- ...
- ...

## Contributing

Please read our [contributing guide](./docs/CONTRIBUTING.md) if you're interested in contributing to Walrus template.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_civo"></a> [civo](#provider\_civo) | >= 1.0.49 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [civo_kubernetes_cluster.my-cluster](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/kubernetes_cluster) | resource |
| [civo_network.custom_net](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/network) | resource |
| [civo_firewall.custom_rule](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster_name](#input\_cluster_name) | Name of the Kubernetes cluster. | `string` | n/a | yes |
| <a name="input_network_label"></a> [network_label](#input\_network_label) | Label for the network. | `string` | n/a | yes |
| <a name="input_firewall_name"></a> [firewall_name](#input\_firewall_name) | Name of the firewall rule set. | `string` | n/a | yes |
| <a name="input_node_pool_label"></a> [node_pool_label](#input\_node_pool_label) | Label for the node pool. | `string` | n/a | yes |
| <a name="input_network_cidr_v4"></a> [network_cidr_v4](#input\_network\_cidr\_v4) | CIDR block for the network. | `string` | n/a | yes |
| <a name="input_network_nameservers_v4"></a> [network_nameservers_v4](#input\_network_nameservers_v4) | List of nameservers for the network. | `list(string)` | `[]` | no |
| <a name="input_kubernetes_version"></a> [kubernetes_version](#input\_kubernetes_version) | Version of Kubernetes to use. | `string` | `"1.27.0"` | no |
| <a name="input_region"></a> [region](#input\_region) | Civo region to deploy the cluster. | `string` | `"NYC1"` | no |
| <a name="input_cluster_type"></a> [cluster_type](#input\_cluster_type) | Type of cluster (e.g., `talos`, `k3s`). | `string` | `"talos"` | no |
| <a name="input_cni"></a> [cni](#input\_cni) | CNI plugin to use (e.g., `flannel`, `cilium`). | `string` | `"flannel"` | no |
| <a name="input_node_size"></a> [node_size](#input\_node_size) | Size of the nodes in the pool. | `string` | `"g4p.kube.small"` | no |
| <a name="input_node_count"></a> [node_count](#input\_node_count) | Number of nodes in the pool. | `number` | `3` | no |
| <a name="input_local_cidr"></a> [local_cidr](#input\_local_cidr) | Local CIDR for ingress firewall rules. | `list(string)` | `[]` | no |
| <a name="input_external_network"></a> [external_network](#input\_external_network) | external CIDR for kubectl access. | `list(string)` | `["0.0.0.0/0"]` | no |
| <a name="input_default_cidr"></a> [default_cidr](#input\_default_cidr) | default CIDR 0.0.0.0/0. | `list(string)` | `["0.0.0.0/0"]` | no |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_submodule"></a> [submodule](#output\_submodule) | The message from submodule. |
| <a name="output_walrus_environment_id"></a> [walrus\_environment\_id](#output\_walrus\_environment\_id) | The id of environment where deployed in Walrus. |
| <a name="output_walrus_environment_name"></a> [walrus\_environment\_name](#output\_walrus\_environment\_name) | The name of environment where deployed in Walrus. |
| <a name="output_walrus_project_id"></a> [walrus\_project\_id](#output\_walrus\_project\_id) | The id of project where deployed in Walrus. |
| <a name="output_walrus_project_name"></a> [walrus\_project\_name](#output\_walrus\_project\_name) | The name of project where deployed in Walrus. |
| <a name="output_walrus_resource_id"></a> [walrus\_resource\_id](#output\_walrus\_resource\_id) | The id of resource where deployed in Walrus. |
| <a name="output_walrus_resource_name"></a> [walrus\_resource\_name](#output\_walrus\_resource\_name) | The name of resource where deployed in Walrus. |
<!-- END_TF_DOCS -->

## License

Copyright (c) 2023 [Seal, Inc.](https://seal.io)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [LICENSE](./LICENSE) file for details.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
