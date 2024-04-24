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

resource "aws_s3_bucket" "test-create-s3-bucket" {
  bucket = "test_create_s3_bucket"
}

resource "aws_s3_bucket" "test-create-s3-bucket-second" {
  bucket = "test_create_s3_bucket-second"
}

