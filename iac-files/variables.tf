terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

variable "keypair" {
  default = "ziya2"   #change here
}

variable "instancetype" {
  default = "t3a.medium"
}

variable "tag" {
  default = "Jenkins_Server_Ziya"
}

variable "jenkins-sg" {
  default = "jenkins-server-sec-gr"
}

variable "docker_user" {
  default = "ziyaasici"
}

variable "docker_ami" {
  default = "ami-0d7a109bf30624c99"
}

variable "ecr" {
  default = "ziyaasici/jenkins"
}