# k8s_onboarding_credentials

Create onboarding credentials for Kubernetes clusters

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform] | >= 1.7 |
| <a name="requirement_helm"></a> [illumio-cloudsecure] | >= 3.15 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_illumio-cloudsecure"></a> [aws] | >= 1.0.9 |
| <a name="provider_helm"></a> [aws] | >= 2.15.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudsecure_k8s_cluster_onboarding_credential.this](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/k8s_cluster_onboarding_credential) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_illumio_region"></a> illumio_region | Illumio Region where the k8s cluster can be onboarded using this credential. An Illumio Region is a designated cloud region where the CloudSecure k8s operators in onboarded k8s clusters connect after onboarding. Choose the Illumio Region nearest to each cluster to maximize performance and security. Must be one of: aws-ap-southeast-2, aws-eu-west-2, aws-us-west-2. |	string	| n/a	| yes |
| <a name="input_name"></a> name |	Display name for the onboarding credential.	| string |	n/a	| yes |
|<a name="input_description"></a> description |	Description of the onboarding credential. |	string |	null	|no|

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> client_id	| Client identifier used by CloudSecure's k8s operator to authenticate to CloudSecure for onboarding, in combination with client_secret. Identical to id. |
|<a name="output_client_secret"></a> client_secret | Client secret used by CloudSecure's k8s operator to authenticate to CloudSecure for onboarding, in combination with client_id.|
|<a name="output_created_at"></a> created_at | Timestamp of the creation of the onboarding credential, in RFC 3339 format.
|<a name="output_id"></a> id | CloudSecure ID.|