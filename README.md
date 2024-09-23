# Illumio Terraform Submodules
Terraform submodules that add functionality to Illumios terraform provider. See the modules directory for the various sub modules usage.


## Availible Features
1. Onboarding and deploying a cloud-opeartor and credentials to a k8s cluster
   
## Usage

```
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Adjust this path as needed
  }
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "k8s_cluster" {
  source            = "github.com/illumio/terraform-illumio-cloudsecure//modules/k8s_cluster?ref=v0.0.3"
  illumio_region    = var.illumio_region
  name              = var.name
  description       = var.description
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | ~> 1.0.9 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->