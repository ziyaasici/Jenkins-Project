# resource "aws_key_pair" "TF_key" {
#     key_name = "TF_key"
#     public_key = tls_private_key.rsa.public_key_openssh
# }

# resource "tls_private_key" "rsa" {
#     algorithm = "RSA"
#     rsa_bits = 4096
# }

# resource "local_file" "docker-key" {
#     content = tls_private_key.rsa.public_key_openssh
#     filename = "TF_key.pem"
# }

# resource "aws_instance" "tf-ec2" {
#     ami           = "ami-0d7a109bf30624c99"
#     instance_type = "t2.micro"
#     key_name = "TF_key"
# }

resource "aws_key_pair" "my_keypair" {
  key_name   = "my-keypair"
  public_key = file("/var/lib/jenkins/workspace/Jenkins-Project/terraform-files/ziya3.pub")
}

