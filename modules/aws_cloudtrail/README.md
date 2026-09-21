<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_log_bucket"></a> [log\_bucket](#module\_log\_bucket) | ../aws_cloudtrail_s3_bucket | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_event_selectors"></a> [advanced\_event\_selectors](#input\_advanced\_event\_selectors) | The advanced event selectors of the trail. The default logs management events plus data events for S3 objects, DynamoDB tables, DSQL clusters, Lambda functions, and RDS DB clusters. Data events are billed per event, so narrow or drop those entries to cut cost. For best threat detection, we recommend enabling all these events, but threat detection still works with only management events enabled. | <pre>list(object({<br/>    name = optional(string)<br/>    field_selector = list(object({<br/>      field           = string<br/>      equals          = optional(list(string))<br/>      not_equals      = optional(list(string))<br/>      starts_with     = optional(list(string))<br/>      not_starts_with = optional(list(string))<br/>      ends_with       = optional(list(string))<br/>      not_ends_with   = optional(list(string))<br/>    }))<br/>  }))</pre> | <pre>[<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Data"<br/>        ],<br/>        "field": "eventCategory"<br/>      },<br/>      {<br/>        "equals": [<br/>          "AWS::S3::Object"<br/>        ],<br/>        "field": "resources.type"<br/>      }<br/>    ]<br/>  },<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Data"<br/>        ],<br/>        "field": "eventCategory"<br/>      },<br/>      {<br/>        "equals": [<br/>          "AWS::DynamoDB::Table"<br/>        ],<br/>        "field": "resources.type"<br/>      }<br/>    ]<br/>  },<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Data"<br/>        ],<br/>        "field": "eventCategory"<br/>      },<br/>      {<br/>        "equals": [<br/>          "AWS::DSQL::Cluster"<br/>        ],<br/>        "field": "resources.type"<br/>      }<br/>    ]<br/>  },<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Data"<br/>        ],<br/>        "field": "eventCategory"<br/>      },<br/>      {<br/>        "equals": [<br/>          "AWS::Lambda::Function"<br/>        ],<br/>        "field": "resources.type"<br/>      }<br/>    ]<br/>  },<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Data"<br/>        ],<br/>        "field": "eventCategory"<br/>      },<br/>      {<br/>        "equals": [<br/>          "AWS::RDS::DBCluster"<br/>        ],<br/>        "field": "resources.type"<br/>      }<br/>    ]<br/>  },<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Management"<br/>        ],<br/>        "field": "eventCategory"<br/>      }<br/>    ],<br/>    "name": "Management events selector"<br/>  }<br/>]</pre> | no |
| <a name="input_bucket_blocked_encryption_types"></a> [bucket\_blocked\_encryption\_types](#input\_bucket\_blocked\_encryption\_types) | The encryption types rejected on upload into the log bucket. If null, the S3 default is left in place. Only used when create\_s3\_bucket is true. | `list(string)` | <pre>[<br/>  "SSE-C"<br/>]</pre> | no |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | If true, allows Terraform to delete the log bucket even when it still contains log files. Only used when create\_s3\_bucket is true. | `bool` | `false` | no |
| <a name="input_bucket_key_enabled"></a> [bucket\_key\_enabled](#input\_bucket\_key\_enabled) | If true, enables S3 Bucket Keys on the log bucket, which cut the cost of SSE-KMS requests. Has no effect while bucket\_sse\_algorithm is "AES256". Only used when create\_s3\_bucket is true. | `bool` | `true` | no |
| <a name="input_bucket_kms_master_key_id"></a> [bucket\_kms\_master\_key\_id](#input\_bucket\_kms\_master\_key\_id) | The KMS key used for the log bucket's default encryption. Only applied when create\_s3\_bucket is true and bucket\_sse\_algorithm is "aws:kms". | `string` | `null` | no |
| <a name="input_bucket_sse_algorithm"></a> [bucket\_sse\_algorithm](#input\_bucket\_sse\_algorithm) | The log bucket's default server-side encryption algorithm. Must be one of: `AES256`, `aws:kms`. Only used when create\_s3\_bucket is true. | `string` | `"AES256"` | no |
| <a name="input_bucket_versioning_enabled"></a> [bucket\_versioning\_enabled](#input\_bucket\_versioning\_enabled) | If true, enables S3 versioning on the log bucket. Only used when create\_s3\_bucket is true. | `bool` | `false` | no |
| <a name="input_cloud_watch_logs_group_arn"></a> [cloud\_watch\_logs\_group\_arn](#input\_cloud\_watch\_logs\_group\_arn) | The ARN of the CloudWatch Logs log stream the trail delivers events to. Must be set together with cloud\_watch\_logs\_role\_arn. | `string` | `null` | no |
| <a name="input_cloud_watch_logs_role_arn"></a> [cloud\_watch\_logs\_role\_arn](#input\_cloud\_watch\_logs\_role\_arn) | The ARN of the IAM role CloudTrail assumes to write into CloudWatch Logs. Must be set together with cloud\_watch\_logs\_group\_arn. | `string` | `null` | no |
| <a name="input_create_s3_bucket"></a> [create\_s3\_bucket](#input\_create\_s3\_bucket) | If true, creates the log bucket, its bucket policy, encryption and public access block in this module. Set to false to reuse an existing bucket, e.g. a bucket in another Region, which a module cannot create because it cannot select a provider conditionally. | `bool` | `true` | no |
| <a name="input_cross_account_reader_actions"></a> [cross\_account\_reader\_actions](#input\_cross\_account\_reader\_actions) | The S3 actions granted to cross\_account\_reader\_arns. The default is read-only; widening it lets the other account delete log files or replace the bucket policy. Only used when create\_s3\_bucket is true. | `list(string)` | <pre>[<br/>  "s3:GetObject",<br/>  "s3:ListBucket",<br/>  "s3:GetBucketLocation"<br/>]</pre> | no |
| <a name="input_cross_account_reader_arns"></a> [cross\_account\_reader\_arns](#input\_cross\_account\_reader\_arns) | The ARNs of the IAM principals from other accounts that are granted access to the log bucket. Only used when create\_s3\_bucket is true. | `list(string)` | `[]` | no |
| <a name="input_enable_log_file_validation"></a> [enable\_log\_file\_validation](#input\_enable\_log\_file\_validation) | If true, delivers digest files so the integrity of the log files can be verified. | `bool` | `true` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | If true, starts logging right after the trail is created. | `bool` | `true` | no |
| <a name="input_include_global_service_events"></a> [include\_global\_service\_events](#input\_include\_global\_service\_events) | If true, includes events from global services such as IAM. | `bool` | `true` | no |
| <a name="input_insight_types"></a> [insight\_types](#input\_insight\_types) | The CloudTrail Insights types to enable. May contain `ApiCallRateInsight` and/or `ApiErrorRateInsight`. | `list(string)` | `[]` | no |
| <a name="input_is_multi_region_trail"></a> [is\_multi\_region\_trail](#input\_is\_multi\_region\_trail) | If true, captures events from every Region. If false, only the trail's home Region is captured, although global service events still arrive when include\_global\_service\_events is true. | `bool` | `true` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | If true, creates an organization trail. Requires running in the management account or in a delegated administrator account. | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN or ID of the KMS key used for SSE-KMS on the delivered log files. If null, CloudTrail uses SSE-S3. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the CloudTrail trail. | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | The AWS Organizations organization ID (e.g., o-xxxxxxxxxx) whose AWSLogs/<organization-id>/ path the log bucket policy grants. When null and both is\_organization\_trail and create\_s3\_bucket are true, the module looks the ID up with the aws\_organizations\_organization data source, which requires the organizations:DescribeOrganization permission. | `string` | `null` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of the S3 bucket that receives the log files. Created by this module when create\_s3\_bucket is true, otherwise it must already exist and already grant CloudTrail write access. | `string` | n/a | yes |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | The prefix prepended to the AWSLogs/ path inside the log bucket. If null, no prefix is used. | `string` | `null` | no |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | The SNS topic that receives log file delivery notifications. If null, no notifications are sent. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The optional tags added to every configured AWS resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudsecure_id"></a> [cloudsecure\_id](#output\_cloudsecure\_id) | The CloudSecure ID of the registered log bucket, null when the bucket is not managed by this module. |
| <a name="output_log_prefix"></a> [log\_prefix](#output\_log\_prefix) | The key prefix the log files are written under, empty when no prefix is used. |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the log bucket, null when the bucket is not managed by this module. |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | The name of the log bucket. |
| <a name="output_trail_arn"></a> [trail\_arn](#output\_trail\_arn) | The ARN of the trail. |
| <a name="output_trail_home_region"></a> [trail\_home\_region](#output\_trail\_home\_region) | The home Region of the trail. |
| <a name="output_trail_id"></a> [trail\_id](#output\_trail\_id) | The ID of the trail. |
| <a name="output_trail_name"></a> [trail\_name](#output\_trail\_name) | The name of the trail. |
<!-- END_TF_DOCS -->
