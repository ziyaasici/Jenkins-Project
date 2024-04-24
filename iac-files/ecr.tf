resource "aws_ecr_repository" "ziyaasici-ECR" {
  name                 = var.ecr
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "Jenkins Project ECR"
    Environment = "Production"
  }
}