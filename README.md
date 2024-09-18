<!-- BEGIN_TF_DOCS -->
# Illumio Terraform Modules

This repository contains Terraform modules for managing Illumio CloudSecure resources. Each submodule is designed to handle specific aspects of Illumio CloudSecure, making it easier to manage and deploy resources in a consistent and reusable manner.

## Available Features
Onboard K8 clusters to CloudSecure 

## Usage

### Example: K8s Cluster Onboarding
```
module "k8s_cluster" {
  source         = "github.com/illumio/terraform-illumio-cloudsecure//modules/k8s_cluster?ref=v0.0.3"
  illumio_region = "aws-us-west-2"
  name           = "dev-cluster-1"

  # Optional variables
  description      = "Development Cluster 1"
  operator_namespace        = "illumio-cloud" # default
  create_operator_namespace = true # default
}
```

### Requirements
| Name | Version |
|------|---------|
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | ~> 1.0.9 |

### License
This project is licensed under the Mozilla Public License Version 2.0. See the LICENSE file for details.

### Authors
This project is maintained by the Illumio Team.
<!-- END_TF_DOCS -->