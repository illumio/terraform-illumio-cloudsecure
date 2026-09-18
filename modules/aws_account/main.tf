locals {
  use_existing_role  = var.role_arn != null
  role_arn           = local.use_existing_role ? var.role_arn : aws_iam_role.role[0].arn
  role_external_id   = local.use_existing_role ? var.role_external_id : random_password.role_secret[0].result
  account_id         = var.account_id != null ? var.account_id : data.aws_caller_identity.current[0].account_id
  organization_id    = var.organization_id != null ? var.organization_id : data.aws_organizations_organization.current[0].id
  cloudtrail_name    = var.cloudtrail_name != null ? var.cloudtrail_name : "${var.iam_name_prefix}Trail"
  cloudtrail_present = var.create_cloudtrail || var.existing_cloudtrail_present
}

data "aws_partition" "current" {
  count = local.use_existing_role ? 0 : 1
}

resource "random_password" "role_secret" {
  count       = local.use_existing_role ? 0 : 1
  length      = 36
  special     = false
  upper       = false
  min_numeric = 6
}

resource "aws_iam_role_policy" "read" {
  count = local.use_existing_role ? 0 : 1
  name  = "${var.iam_name_prefix}Policy"
  role  = aws_iam_role.role[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
          "eks:DescribeAddon",
          "eks:ListAddons",
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
          "xray:GetTraceSummaries",
          "networkmanager:ListCoreNetworks",
          "networkmanager:GetCoreNetwork",
          "networkmanager:ListAttachments",
          "networkmanager:GetVpcAttachment",
          "networkmanager:GetSiteToSiteVpnAttachment",
          "networkmanager:GetConnectAttachment",
          "networkmanager:GetTransitGatewayRouteTableAttachment",
          "networkmanager:ListPeerings",
          "networkmanager:GetTransitGatewayPeering",
          "networkmanager:GetTransitGatewayRegistrations"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "protection" {
  count = (!local.use_existing_role && var.mode == "ReadWrite") ? 1 : 0
  name  = "${var.iam_name_prefix}ProtectionPolicy"
  role  = aws_iam_role.role[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
          "ec2:ModifySecurityGroupRules",
          "ec2:ModifyNetworkInterfaceAttribute",
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
          "arn:aws:ec2:*:*:network-acl/*",
          "arn:aws:ec2:*:*:vpc/*",
          "arn:aws:ec2:*:*:network-interface/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "role" {
  count = local.use_existing_role ? 0 : 1
  name  = "${var.iam_name_prefix}Role"
  tags  = var.tags
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:${data.aws_partition.current[0].partition}:iam::${var.illumio_cloudsecure_account_id}:root"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = random_password.role_secret[0].result
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attachment" {
  count      = local.use_existing_role ? 0 : 1
  role       = aws_iam_role.role[0].name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

# Optionally create a CloudTrail trail as part of onboarding. The trail delivers
# to a pre-existing bucket that already grants CloudTrail delivery permission.
resource "aws_cloudtrail" "this" {
  count                         = var.create_cloudtrail ? 1 : 0
  name                          = local.cloudtrail_name
  s3_bucket_name                = var.cloudtrail_s3_bucket_name
  is_multi_region_trail         = var.cloudtrail_is_multi_region_trail
  include_global_service_events = var.cloudtrail_include_global_service_events
  enable_log_file_validation    = var.cloudtrail_enable_log_file_validation
  tags                          = var.tags
}

# Data source to get the AWS account ID.
data "aws_caller_identity" "current" {
  count = var.account_id == null ? 1 : 0
}

# Data source to get the AWS org.
data "aws_organizations_organization" "current" {
  count = var.organization_id == null ? 1 : 0
}

// Onboards this AWS account with CloudSecure.
resource "illumio-cloudsecure_aws_account" "account" {
  account_id       = local.account_id
  mode             = var.mode
  name             = var.name
  organization_id  = local.organization_id
  role_arn         = local.role_arn
  role_external_id = local.role_external_id

  lifecycle {
    precondition {
      condition     = !var.require_cloudtrail || local.cloudtrail_present
      error_message = "Onboarding requires an AWS CloudTrail trail, but none was found and create_cloudtrail is false. Set create_cloudtrail = true to create one, or existing_cloudtrail_present = true if a trail already exists."
    }
  }
}
