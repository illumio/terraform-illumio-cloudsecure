<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 7.14.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 7.14.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | >= 1.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_binding.pubsub_access_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_custom_role.flow_access_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.pubsub_access_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_pubsub_topic_iam_binding.flow_access_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic_iam_binding) | resource |
| [illumio-cloudsecure_gcp_flow_logs_pubsub_topic.flow_logs](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/gcp_flow_logs_pubsub_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_name_prefix"></a> [iam\_name\_prefix](#input\_iam\_name\_prefix) | The prefix given to all GCP IAM resource names. | `string` | `"IllumioCloudIntegration"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP Project ID. | `string` | n/a | yes |
| <a name="input_pubsub_topic_ids"></a> [pubsub\_topic\_ids](#input\_pubsub\_topic\_ids) | The set of resource IDs of the GCP Pub/Sub topics containing flow logs, in the format projects/<project>/topics/<topic>. | `set(string)` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | The email of the service account to grant permissions to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_role_id"></a> [project\_role\_id](#output\_project\_role\_id) | The ID of the custom IAM role created for Pub/Sub subscription management. |
| <a name="output_topic_role_id"></a> [topic\_role\_id](#output\_topic\_role\_id) | The ID of the custom IAM role created for attaching subscriptions to GCP Pub/Sub topics. |
<!-- END_TF_DOCS -->