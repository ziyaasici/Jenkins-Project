resource "aws_key_pair" "key-pair" {
    key_name = docker-key-pair
    public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "docker-key" {
    content = tls_private_key.rsa.tls_private_key_pem
    filename = "docker"
}