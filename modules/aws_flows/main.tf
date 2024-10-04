terraform {
  required_providers {
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = "~> 1.0.11"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

locals {
  # Extract just the bucket ARN (without paths) for ListBucket actions
  flow_logs_bucket_list = [
    for bucket_arn in var.flow_logs_bucket_arns : regex("^arn:aws:s3:::[^/]+", bucket_arn)
  ]

  # Use the full ARN with path for GetObject actions
  flow_logs_bucket_read = [
    for bucket_arn in var.flow_logs_bucket_arns : "${bucket_arn}/*"
  ]
}

data "aws_iam_role" "illumio_cloud_integration_role" {
  name = var.role_arn
}

resource "aws_iam_role_policy" "IllumioCloudBucketListPolicy" {
  count = length(local.flow_logs_bucket_list) > 0 ? 1 : 0
  name  = "IllumioCloudBucketListPolicy"
  role  = data.aws_iam_role.illumio_cloud_integration_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Sid    = "IllumioBucketListAccess"
      Action = [
        "s3:ListBucket",
        "s3:ListBucketVersion",
        "s3:GetBucketLocation"
      ]
      Resource = local.flow_logs_bucket_list
    }]
  })
}

resource "aws_iam_role_policy" "IllumioCloudBucketReadPolicy" {
  count = length(local.flow_logs_bucket_read) > 0 ? 1 : 0
  name  = "IllumioCloudBucketReadPolicy"
  role  = data.aws_iam_role.illumio_cloud_integration_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Sid    = "IllumioBucketReadAccess"
      Action = ["s3:GetObject"]
      Resource = local.flow_logs_bucket_read
    }]
  })
}

# Data source to get the AWS account ID.
data "aws_caller_identity" "current" {}


// Onboards this AWS account with CloudSecure.
resource "illumio-cloudsecure_aws_flow_logs_s3_bucket" "buckets" {
  for_each = toset(var.flow_logs_bucket_arns)
  account_id       = data.aws_caller_identity.current.account_id
  s3_bucket_arn    = each.key
}
