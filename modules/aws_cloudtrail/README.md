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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_event_selectors"></a> [advanced\_event\_selectors](#input\_advanced\_event\_selectors) | The advanced event selectors of the trail. The default logs management events plus data events for S3 objects, DynamoDB tables, DSQL clusters, Lambda functions, and RDS DB clusters. Data events are billed per event, so narrow or drop those entries to cut cost. For best threat detection, we recommend enabling all these events, but threat detection still works with only management events enabled. | <pre>list(object({<br/>    name = optional(string)<br/>    field_selector = list(object({<br/>      field           = string<br/>      equals          = optional(list(string))<br/>      not_equals      = optional(list(string))<br/>      starts_with     = optional(list(string))<br/>      not_starts_with = optional(list(string))<br/>      ends_with       = optional(list(string))<br/>      not_ends_with   = optional(list(string))<br/>    }))<br/>  }))</pre> | <pre>[<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Data"<br/>        ],<br/>        "field": "eventCategory"<br/>      },<br/>      {<br/>        "equals": [<br/>          "AWS::S3::Object"<br/>        ],<br/>        "field": "resources.type"<br/>      }<br/>    ]<br/>  },<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Data"<br/>        ],<br/>        "field": "eventCategory"<br/>      },<br/>      {<br/>        "equals": [<br/>          "AWS::DynamoDB::Table"<br/>        ],<br/>        "field": "resources.type"<br/>      }<br/>    ]<br/>  },<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Data"<br/>        ],<br/>        "field": "eventCategory"<br/>      },<br/>      {<br/>        "equals": [<br/>          "AWS::DSQL::Cluster"<br/>        ],<br/>        "field": "resources.type"<br/>      }<br/>    ]<br/>  },<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Data"<br/>        ],<br/>        "field": "eventCategory"<br/>      },<br/>      {<br/>        "equals": [<br/>          "AWS::Lambda::Function"<br/>        ],<br/>        "field": "resources.type"<br/>      }<br/>    ]<br/>  },<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Data"<br/>        ],<br/>        "field": "eventCategory"<br/>      },<br/>      {<br/>        "equals": [<br/>          "AWS::RDS::DBCluster"<br/>        ],<br/>        "field": "resources.type"<br/>      }<br/>    ]<br/>  },<br/>  {<br/>    "field_selector": [<br/>      {<br/>        "equals": [<br/>          "Management"<br/>        ],<br/>        "field": "eventCategory"<br/>      }<br/>    ],<br/>    "name": "Management events selector"<br/>  }<br/>]</pre> | no |
| <a name="input_cloud_watch_logs_group_arn"></a> [cloud\_watch\_logs\_group\_arn](#input\_cloud\_watch\_logs\_group\_arn) | The ARN of the CloudWatch Logs log group the trail delivers events to, followed by the log stream wildcard `:*`. Must be set together with cloud\_watch\_logs\_role\_arn. | `string` | `null` | no |
| <a name="input_cloud_watch_logs_role_arn"></a> [cloud\_watch\_logs\_role\_arn](#input\_cloud\_watch\_logs\_role\_arn) | The ARN of the IAM role CloudTrail assumes to write into CloudWatch Logs. Must be set together with cloud\_watch\_logs\_group\_arn. | `string` | `null` | no |
| <a name="input_enable_log_file_validation"></a> [enable\_log\_file\_validation](#input\_enable\_log\_file\_validation) | If true, delivers digest files so the integrity of the log files can be verified. | `bool` | `true` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | If true, starts logging right after the trail is created. | `bool` | `true` | no |
| <a name="input_include_global_service_events"></a> [include\_global\_service\_events](#input\_include\_global\_service\_events) | If true, includes events from global services such as IAM. | `bool` | `true` | no |
| <a name="input_insight_types"></a> [insight\_types](#input\_insight\_types) | The CloudTrail Insights types to enable. May contain `ApiCallRateInsight` and/or `ApiErrorRateInsight`. | `list(string)` | `[]` | no |
| <a name="input_is_multi_region_trail"></a> [is\_multi\_region\_trail](#input\_is\_multi\_region\_trail) | If true, captures events from every Region. If false, only the trail's home Region is captured, and global service events are delivered only if the home Region is the partition's leader Region (e.g., us-east-1), even when include\_global\_service\_events is true. | `bool` | `true` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | If true, creates an organization trail. Requires running in the management account or in a delegated administrator account. Must be the same as the is\_organization\_trail value of the aws\_cloudtrail\_s3\_bucket module. | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN of the KMS key used for SSE-KMS on the delivered log files. The key must be in the same Region as the S3 bucket. If null, CloudTrail uses SSE-S3. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the CloudTrail trail. Must be set from the trail\_name output of the aws\_cloudtrail\_s3\_bucket module, so that it matches the trail name in the bucket policy. | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of the S3 bucket that receives the log files. The bucket must be created with the aws\_cloudtrail\_s3\_bucket module, which also onboards it with CloudSecure. Must be set from the s3\_bucket\_name output of that module, so that the trail is created after the bucket policy and after the bucket is onboarded. | `string` | n/a | yes |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | The prefix prepended to the AWSLogs/ path inside the log bucket. Must be set from the s3\_key\_prefix output of the aws\_cloudtrail\_s3\_bucket module. If null, no prefix is used. | `string` | `null` | no |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | The SNS topic that receives log file delivery notifications. If null, no notifications are sent. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The optional tags added to every configured AWS resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_trail_id"></a> [trail\_id](#output\_trail\_id) | The ID of the trail. |
<!-- END_TF_DOCS -->
