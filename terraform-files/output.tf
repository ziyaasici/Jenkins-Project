# output "ecr_repository_url" {
#   value = aws_ecr_repository.ziyaasici-ECR.repository_url
# }
# output "myec2-public-ip" {
#   value = aws_instance.tf-ec2.public_ip
# }

output "ssh-connection-command" {
  value = "ssh -i ${aws_key_pair.key_docker.key_name}.pem ec2-user@${aws_instance.tf-ec2.public_ip}"
}

output "private_key" {
  value     = file("${path.module}/docker-key.pem")
  sensitive = true
}