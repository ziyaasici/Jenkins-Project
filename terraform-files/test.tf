resource "aws_key_pair" "docker-key" {
  key_name   = "docker-key"
  public_key = file("${path.module}/docker-key.pub")
}


resource "aws_instance" "docker-ec2" {
  ami           = "ami-04e5276ebb8451442"  # Replace with a valid AMI ID
  instance_type = "t2.micro"  # Adjust the instance type as needed
  key_name      = aws_key_pair.docker-key.key_name

  tags = {
    Name = "Docker-Server"
  }
}