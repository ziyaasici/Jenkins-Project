# resource "aws_ecr_repository" "nodejs" {
#   name                 = "nodejs"
#   image_tag_mutability = "MUTABLE"

#   tags = {
#     Name        = "Jenkins Project NodeJS ECR"
#   }
# }

# resource "aws_ecr_repository" "react" {
#   name                 = "react"
#   image_tag_mutability = "MUTABLE"

#   tags = {
#     Name        = "Jenkins Project React ECR"
#   }
# }

# resource "aws_ecr_repository" "postgresql" {
#   name                 = "postgresql"
#   image_tag_mutability = "MUTABLE"

#   tags = {
#     Name        = "Jenkins Project PostgreSQL ECR"
#   }
# }