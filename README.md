# Illumio CloudSecure Terraform Modules
Terraform submodules that add functionality to Illumio's CloudSecure Terraform provider. See the modules directory for the various submodules' usage.

## Available Nested Modules
* [`aws_account`](./modules/aws_account/README.md): onboarding of an AWS account with CloudSecure.
* [`azure_subscription`](./modules/azure_subscription/README.md): onboarding of an Azure subscription with CloudSecure.
* [`aws_flow_logs_s3_buckets`](./modules/aws_flow_logs_s3_buckets/README.md): onboarding of AWS S3 buckets with CloudSecure to access flow logs.
* [`k8s_cluster`](./modules/k8s_cluster/README.md): deployment and onboarding of CloudSecure's `cloud-operator` into a k8s cluster.

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