# Illumio CloudSecure Terraform Modules
Terraform submodules that add functionality to Illumio's CloudSecure Terraform provider. See the modules directory for the various submodules' usage.

## Available Nested Modules
* [`aws_account`](https://registry.terraform.io/modules/illumio/cloudsecure/illumio/latest/submodules/aws_account): onboarding of an AWS account with CloudSecure.
* [`aws_flow_logs_s3_buckets`](https://registry.terraform.io/modules/illumio/cloudsecure/illumio/latest/submodules/aws_flow_logs_s3_buckets): onboarding of AWS S3 buckets with CloudSecure to access flow logs.
* [`azure_subscription`](https://registry.terraform.io/modules/illumio/cloudsecure/illumio/latest/submodules/azure_subscription): onboarding of an Azure subscription with CloudSecure.
* [`azure_flow_logs_storage_accounts`](https://registry.terraform.io/modules/illumio/cloudsecure/illumio/latest/submodules/azure_flow_logs_storage_accounts): onboarding of Azure Storage Accounts with CloudSecure to access flow logs.
* [`gcp_project`](https://registry.terraform.io/modules/illumio/cloudsecure/illumio/latest/submodules/gcp_project): onboarding of a GCP project with CloudSecure.
* [`gcp_flow_logs_pubsub_topic`](https://registry.terraform.io/modules/illumio/cloudsecure/illumio/latest/submodules/gcp_flow_logs_pubsub_topic): onboarding of GCP Pub/Sub topics with CloudSecure to access flow logs.
* [`k8s_cluster`](https://registry.terraform.io/modules/illumio/cloudsecure/illumio/latest/submodules/k8s_cluster): deployment and onboarding of CloudSecure's `cloud-operator` into a k8s cluster.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 1.0.11 |

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