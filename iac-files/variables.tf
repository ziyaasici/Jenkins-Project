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

variable "user" {
  default = "ziyaasici"
}

variable "docker_ami" {
  default = "ami-0d7a109bf30624c99"
}