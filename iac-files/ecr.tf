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
  name                 = "ziyaasici/jenkins"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "Jenkins Project ECR"
    Environment = "Production"
  }
}