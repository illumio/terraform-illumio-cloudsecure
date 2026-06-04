provider "aws" {
  region = "us-west-1"
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "aws_account_dev" {
  source  = "illumio/cloudsecure/illumio//modules/aws_account"
  version = "1.7.0"
  name    = "Test Account"

  # Optional attributes
  iam_name_prefix = "IllumioCloudIntegration"
  mode            = "ReadWrite"

  tags = {
    Name  = "CloudSecure Account Policy"
    Owner = "Engineering"
  }
}

# Reuse a pre-existing IAM role (and its external ID) instead of letting the
# module create the role, its inline policies, and the SecurityAudit attachment.
# role_arn and role_external_id must both be set (or both null).
module "aws_account_existing_role" {
  source           = "illumio/cloudsecure/illumio//modules/aws_account"
  version          = "1.7.0"
  name             = "Test Account (existing role)"
  mode             = "ReadWrite"
  role_arn         = var.role_arn
  role_external_id = var.role_external_id

  tags = {
    Name  = "CloudSecure Account Policy"
    Owner = "Engineering"
  }
}

# At-scale pattern: BYO IAM role plus explicit account_id and organization_id
# to avoid the aws_caller_identity and aws_organizations_organization data
# source calls per account. This is the recommended pattern when onboarding
# many accounts via for_each, or when the calling identity lacks
# organizations:DescribeOrganization.
module "aws_account_at_scale" {
  source  = "illumio/cloudsecure/illumio//modules/aws_account"
  version = "1.7.0"
  name    = "Test Account (at-scale pattern)"
  mode    = "Read"

  role_arn         = var.role_arn
  role_external_id = var.role_external_id

  account_id      = var.account_id
  organization_id = var.organization_id
}
