resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "docker-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "private_key" {
  content = tls_private_key.rsa.private_key_pem
  filename = "docker-key"
}


resource "aws_instance" "Test" {
    ami = "ami-04e5276ebb8451442"
    instance_type = "t2.micro"
    key_name = aws_key_pair.key_pair.key_name
    tags = {
        Name= "Test-REST"
    }
    depends_on = [ aws_key_pair.key_pair ]
}