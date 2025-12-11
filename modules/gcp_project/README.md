<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 1.7.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | >= 1.7.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.12 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_custom_role.api_enable_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.write_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.api_enable_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.predefined_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.write_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.required_apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.illumio_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.impersonation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [illumio-cloudsecure_gcp_project.project](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/gcp_project) | resource |
| [time_static.timestamp](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_illumio_service_account_email"></a> [illumio\_service\_account\_email](#input\_illumio\_service\_account\_email) | The Illumio Service Account Email that will impersonate the created Service Account. | `string` | `"illumio-onboarding@cs-prod-01.iam.gserviceaccount.com"` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | The account's access mode, must be "ReadWrite" (default) or "Read". | `string` | `"ReadWrite"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of this project in CloudSecure. | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | The GCP Organization ID. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP Project ID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mode"></a> [mode](#output\_mode) | The account's access mode, must be "ReadWrite" (default) or "Read". |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | The email of the created service account created for Illumio CloudSecure under the provided GCP Project ID. |
<!-- END_TF_DOCS -->