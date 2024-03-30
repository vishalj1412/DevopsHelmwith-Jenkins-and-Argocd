variable "instance_type" {
  description = "instance type for jenkins ec2 server"
  type = string
}

variable "ami_id" {
  description = "ami id of the jenkins ec2 server"
  type = string
}

variable "volume_type" {
  description = "ebs volume type"
  type = string
}

variable "volume_size" {
  description = "ebs volume size"
  type = number
}

variable "key_pair" {
  description = "ec2 key pair"
  type = string
}

variable "public_subnet" {
  description = "public subnet id"
  type = string
}

variable "env" {
  description = "Name & Envionment of the env(XYZ-Prod)"
  type = string
}

variable "vpc_id" {
  description = "vpc id"
  type = string
}

# variable "openvpn_sg" {}