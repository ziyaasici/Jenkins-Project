resource "aws_key_pair" "my_keypair" {
  key_name   = "my-terraform-key"
  public_key = file("${path.module}/my_key.pub")
}

output "private_key" {
  value     = tls_private_key.my_key.private_key_pem
  sensitive = true
}