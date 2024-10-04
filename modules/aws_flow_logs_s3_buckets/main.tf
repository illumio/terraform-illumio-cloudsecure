resource "aws_iam_role_policy" "s3_bucket_read" {
  name   = "${var.iam_name_prefix}BucketReadPolicy"
  role   = var.role_id
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:ListBucket",
          "s3:ListBucketVersion",
          "s3:GetBucketLocation"
        ],
        Resource = var.s3_bucket_arns
      },
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject"
        ],
        Resource = [for arn in var.s3_bucket_arns : replace("${arn}/*", "//*", "/*")]
      }
    ]
  })
}

data "aws_caller_identity" "current" {}

resource "illumio-cloudsecure_aws_flow_logs_s3_bucket" "bucket_example" {
  for_each      = var.s3_bucket_arns
  account_id    = data.aws_caller_identity.current.account_id
  s3_bucket_arn = each.key
}
