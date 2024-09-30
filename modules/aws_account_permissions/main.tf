terraform {
  required_providers {
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = "~> 1.0.10"
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
data "aws_organizations_organization" "current" {}

data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

resource "random_uuid" "role_secret" {}

resource "aws_iam_role_policy" "IllumioCloudAWSIntegrationPolicy" {
  name = "IllumioCloudAWSIntegrationPolicy"
  role = aws_iam_role.illumio_cloud_integration_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "apigateway:GET",
          "autoscaling:Describe*",
          "cloudtrail:DescribeTrails",
          "cloudtrail:GetTrailStatus",
          "cloudtrail:LookupEvents",
          "cloudwatch:Describe*",
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "codedeploy:List*",
          "codedeploy:BatchGet*",
          "directconnect:Describe*",
          "docdb-elastic:GetCluster",
          "docdb-elastic:ListTagsForResource",
          "dynamodb:List*",
          "dynamodb:Describe*",
          "ec2:Describe*",
          "ec2:SearchTransitGatewayMulticastGroups",
          "ecs:Describe*",
          "ecs:List*",
          "elasticache:Describe*",
          "elasticache:List*",
          "elasticfilesystem:DescribeAccessPoints",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:DescribeTags",
          "elasticloadbalancing:Describe*",
          "elasticmapreduce:List*",
          "elasticmapreduce:Describe*",
          "es:ListTags",
          "es:ListDomainNames",
          "es:DescribeElasticsearchDomains",
          "fsx:DescribeFileSystems",
          "fsx:ListTagsForResource",
          "health:DescribeEvents",
          "health:DescribeEventDetails",
          "health:DescribeAffectedEntities",
          "kinesis:List*",
          "kinesis:Describe*",
          "lambda:GetPolicy",
          "lambda:List*",
          "logs:TestMetricFilter",
          "logs:DescribeSubscriptionFilters",
          "organizations:Describe*",
          "organizations:List*",
          "rds:Describe*",
          "rds:List*",
          "redshift:DescribeClusters",
          "redshift:DescribeLoggingStatus",
          "route53:List*",
          "s3:GetBucketLogging",
          "s3:GetBucketLocation",
          "s3:GetBucketNotification",
          "s3:GetBucketTagging",
          "s3:ListAllMyBuckets",
          "sns:List*",
          "sqs:ListQueues",
          "states:ListStateMachines",
          "states:DescribeStateMachine",
          "support:DescribeTrustedAdvisor*",
          "support:RefreshTrustedAdvisorCheck",
          "tag:GetResources",
          "tag:GetTagKeys",
          "tag:GetTagValues",
          "xray:BatchGetTraces",
          "xray:GetTraceSummaries"
        ],
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy" "IllumioCloudAWSProtectionPolicy" {
  count = var.access_mode == "ReadWrite" ? 1 : 0
  name = "IllumioCloudAWSProtectionPolicy"
  role = aws_iam_role.illumio_cloud_integration_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
          "ec2:ModifySecurityGroupRules",
          "ec2:DescribeTags",
          "ec2:CreateTags",
          "ec2:DeleteTags",
          "ec2:DescribeNetworkAcls",
          "ec2:CreateNetworkAclEntry",
          "ec2:ReplaceNetworkAclEntry",
          "ec2:DeleteNetworkAclEntry"
        ],
        Resource = [
          "arn:aws:ec2:*:*:security-group-rule/*",
          "arn:aws:ec2:*:*:security-group/*",
          "arn:aws:ec2:*:*:network-acl/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy" "IllumioCloudBucketListPolicy" {
  count = length(var.flow_logs_buckets)>0 ? 1 : 0
  name = "IllumioCloudBucketListPolicy"
  role = aws_iam_role.illumio_cloud_integration_role.id
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
      Resource = var.flow_logs_buckets
    }]
  })
}
resource "aws_iam_role_policy" "IllumioCloudBucketReadPolicy" {
  count = length(var.flow_logs_buckets) > 0 ? 1 : 0
  name = "IllumioCloudBucketReadPolicy"
  role = aws_iam_role.illumio_cloud_integration_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Sid    = "IllumioBucketReadAccess"
      Action = ["s3:GetObject"]
      Resource = [for bucket in var.flow_logs_buckets : "${bucket}/*"]
    }]
  })
}

resource "aws_iam_role" "illumio_cloud_integration_role" {
  name = var.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = "arn:${data.aws_partition.current.partition}:iam::137706418270:root"
        }
        Action    = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = random_uuid.role_secret.result
          }
        }
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/SecurityAudit"
  ]
}
