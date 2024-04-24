terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_ecr_repository" "ziyaasici-ECR" {
  name                 = "ziyaasici"
  image_tag_mutability = "MUTABLE"

  lifecycle {
    ignore_changes = [
      image_tag_mutability,
      scan_on_push
    ]
  }

  tags = {
    Name        = "Jenkins Project ECR"
    Environment = "Production"
  }
}