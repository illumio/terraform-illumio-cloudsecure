terraform {
  required_version = ">= 1.9"
  required_providers {
    # Same minimum version as the aws_cloudtrail_s3_bucket module, which this module is used with.
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.40.0"
    }
  }
}
