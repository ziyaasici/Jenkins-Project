resource "aws_ecr_repository" "nodejs" {
  name                 = "nodejs"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "Jenkins Project ECR"
    Environment = "Production"
  }
}

resource "aws_ecr_repository" "react" {
  name                 = "react"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "Jenkins Project ECR"
    Environment = "Production"
  }
}

resource "aws_ecr_repository" "postgresql" {
  name                 = "postgresql"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "Jenkins Project ECR"
    Environment = "Production"
  }
}