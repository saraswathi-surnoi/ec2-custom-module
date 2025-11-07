terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.19.0"
    }
  }

  # Optional S3 backend; can be overridden via CLI/env
  backend "s3" {
    bucket  = var.backend_bucket
    key     = var.backend_key
    region  = var.backend_region
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(
      { Project = var.project_name },
      var.common_tags
    )
  }
}
