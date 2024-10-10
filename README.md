# Illumio CloudSecure Terraform Modules
Terraform submodules that add functionality to Illumio's CloudSecure Terraform provider. See the modules directory for the various submodules' usage.

## Available Nested Modules
* `aws_account`: onboarding of an AWS account with CloudSecure.
* `aws_flow_logs_s3_buckets`: onboarding of AWS S3 buckets with CloudSecure to access flow logs.
* `k8s_cluster`: deployment and onboarding of CloudSecure's `cloud-operator` into a k8s cluster.
