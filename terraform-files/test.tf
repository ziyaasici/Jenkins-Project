resource "aws_key_pair" "TF_key" {
    key_name = "TF_key"
    public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "docker-key" {
    content = tls_private_key.rsa.public_key_openssh
    filename = "tfkey"
}

resource "aws_instance" "tf-ec2" {
    ami           = "ami-0d7a109bf30624c99"
    instance_type = "t2.micro"
    key_name = "tfkey"
}