# Illumio Terraform Modules

This repository contains Terraform modules for managing Illumio CloudSecure resources. Each submodule is designed to handle specific aspects of Illumio CloudSecure, making it easier to manage and deploy resources in a consistent and reusable manner.

## Available Features
Onboard K8 clusters to CloudSecure 

## Usage

### Example: K8s Cluster Onboarding
```
module "k8s_clsuter" {
  source            = "./modules/k8s_cluster"
  illumio_region    = var.illumio_region
  name              = var.name
  description       = var.description
  version           = var.operator_version
  namespace         = var.namespace
  create_namespace  = var.create_namespace
}
```

### Requirements
| Name | Version |
|------|---------|
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | ~> 1.0.9 |

### Providers
| Name | Version |
|------|---------|
| <a name="provider_illumio-cloudsecure"></a> illumio-cloudsecure | ~> 1.0.9 |


### Modules
| Name | Source | Version |
|------|---------|-------|
|<a name="k8s_cluster"></a> k8s_cluster |	./modules/k8_cluster| n/a|

### Resources
No resources.

### Inputs
No inputs.

### Outputs
No outputs.

### License
This project is licensed under the Mozilla Public License Version 2.0. See the LICENSE file for details.

### Authors
This project is maintained by the Illumio Team.