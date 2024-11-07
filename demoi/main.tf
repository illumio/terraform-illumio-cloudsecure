locals {
  all_arns_suffixed = [for arn in var.s3_bucket_arns : replace("${arn}/*", "//*", "/*")]
  arns_without_path = tolist(toset([for bucket in var.s3_bucket_arns : bucket if can(regex("^[^/]+$", bucket))]))
  arns_with_path_suffix = [for arn in var.s3_bucket_arns : arn if !can(regex("^[^/]+$", arn))]
  arns_of_buckets_with_path_suffix = [for arn in local.arns_with_path_suffix : regex("^[^/]+", arn)]
}
# output "a1_fullpaths" {
#   value = local.full_bucket_arns
# }
# output "a2_fullpaths_suffixed" {
#   value = local.full_bucket_arns_with_suffix
# }
# output "a3_bucket_arns_from_arns_with_path" {
#   value = local.bucket_arns_from_arns_with_path
# }
# output "a4_arns_with_path_suffixed" {
#   value = local.arns_with_path_suffixed
# }
# output "a5_arns_with_path" {
#   value = local.arns_with_path
# }
# output "a6_map_of_arn_path_from_arns_with_path" {
#   value = local.map_of_arn_path_from_arns_with_path
# }

output "demo" {
  value = jsonencode({
    Version   = "2012-10-17"
    Statement = concat([
      # Allow for entire bucket arns
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        Resource = local.arns_without_path
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketLocation"
        ],
        Resource = local.arns_of_buckets_with_path_suffix
      }
    ],
      [
        for arn in local.arns_with_path_suffix : {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
        ],
        Resource = regex("^[^/]+", arn)
        Condition = {
          StringLike = {
            "s3:prefix" = [
              replace("${regex("/.*/.*", arn)}/*", "//*", "/*")
            ]
          }
        }
      }
      ])
  })
}

output "read" {
  value = jsonencode({
    Version   = "2012-10-17"
    Statement = concat([
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ],
        Resource = local.all_arns_suffixed
      }
    ])
  })
}


variable "s3_bucket_arns" {
  description = "The set of ARNs of AWS S3 buckets containing flow logs."
  type        = set(string)
  default = [
    "arn:aws:s3:::flows-bucket-1",
    "arn:aws:s3:::flows-bucket-2",
    "arn:aws:s3:::flows-bucket-3",
    "arn:aws:s3:::flows-bucket-4/custom-path/first",
    "arn:aws:s3:::flows-bucket-5/custom-path/second"
  ]
  validation {
    condition     = length(var.s3_bucket_arns) > 0
    error_message = "The s3_bucket_arns value must not be empty."
  }
}
