<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.0 |
| <a name="requirement_illumio-cloudsecure"></a> [illumio-cloudsecure](#requirement\_illumio-cloudsecure) | >= 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.0 |
| <a name="provider_illumio-cloudsecure"></a> [illumio-cloudsecure](#provider\_illumio-cloudsecure) | >= 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.object_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [illumio-cloudsecure_gcp_flow_logs_storage_bucket_source.this](https://registry.terraform.io/providers/illumio/illumio-cloudsecure/latest/docs/resources/gcp_flow_logs_storage_bucket_source) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_location"></a> [bucket\_location](#input\_bucket\_location) | The location of the buckets created when create\_bucket is true (e.g., US, EU, us-central1). | `string` | `null` | no |
| <a name="input_buckets"></a> [buckets](#input\_buckets) | The set of existing Cloud Storage buckets receiving flow logs to register with CloudSecure by name and (optional) path prefix. No bucket is created unless create\_bucket is true. | <pre>set(object({<br/>    bucket_name = string<br/>    path_prefix = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | When true, create each Cloud Storage bucket. Defaults to false because customers usually already have a bucket receiving flow logs. Configuring flow log delivery to the bucket remains the caller's responsibility. bucket\_location is required when this is true. | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | The optional labels added to every Cloud Storage bucket created when create\_bucket is true. | `map(string)` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the GCP project that owns the storage buckets. | `string` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | The email of the service account used by CloudSecure to read the buckets. When set, the module grants it roles/storage.objectViewer on each registered bucket. When null, granting CloudSecure read access is the caller's responsibility. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_names"></a> [bucket\_names](#output\_bucket\_names) | The set of registered Cloud Storage bucket names. |
| <a name="output_source_ids"></a> [source\_ids](#output\_source\_ids) | Map of bucket key ("<bucket\_name>" or "<bucket\_name>::<path\_prefix>") to the CloudSecure flow logs storage bucket source ID. |
<!-- END_TF_DOCS -->
