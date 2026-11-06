terraform {
  required_version = ">= 1.9"
  required_providers {
    # 6.22.0 adds blocked_encryption_types, 6.40.0 stops it from producing a perpetual diff.
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.40.0"
    }
  }
}
