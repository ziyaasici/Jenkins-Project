locals {
  instance-type = var.instancetype
  secgr-dynamic-ports = [22,80,443,8080,5000,5432,3000]
  user = var.docker_user
  ami = var.docker_ami
}

resource "aws_security_group" "allow_ssh" {
  name        = "${local.user}-docker-instance-sg"
  description = "Allow SSH inbound traffic"

  dynamic "ingress" {
    for_each = local.secgr-dynamic-ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

  egress {
    description = "Outbound Allowed"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "tf-ec2" {
  ami           = local.ami
  instance_type = local.instance-type
  key_name = "DockerKey"                                                #DEGISTIR
  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ]
  tags = {
      Name = "${local.user}-Docker"
  }

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname docker_instance
              yum update -y
              yum install docker -y
              systemctl start docker
              systemctl enable docker
              usermod -a -G docker ec2-user
              newgrp docker
              # install docker-compose
              curl -SL https://github.com/docker/compose/releases/download/v2.24.7/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose
	          EOF
}  
