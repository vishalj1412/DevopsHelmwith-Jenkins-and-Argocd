variable "instance_count"{}
variable "vpc_id_ec2" {
  description = "ID of the VPC"
  type        = string
}
variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}

variable "instance_names" {
  description = "Names for the EC2 instances"
  type        = list(string)
  # Update with your desired instance names
}

variable "ami" {}
variable"sg_name"{}
variable "instance_type"{}
variable "key_name"{}
variable "cidr_ssh"{}
