variable "env" {
  description = "Name & Envionment of the env"
  type = string
}
#variable "cl-role" {
#  description = "EKS CLuster Role ARN"
#  type = string
#}
#variable "ng-role" {
#  description = "EKS CLuster Role ARN"
#  type = string
#}
# variable "eks-sg" {
#   description = "Security group to allow access"
#   type = list(string)
# }
variable "eks-cl-subnet" {
  description = "Subnet Ids for launching the eks cluster"
  type = list(string)
}
variable "eks-ng-subnet" {
  description = "Subnet Ids for launching the eks nodegroup"
  type = list(string)
}
variable "eks-ng-subnet1" {
  description = "Subnet Ids for launching the eks nodegroup"
  type = list(string)
}
variable "kms-arn" {
  description = "ARN of the KMS Key"
  type = string
}
# variable "key-pair" {
#   description = "Key Pair to login the Nodes"
#   type = string
# }
variable "purpose" {
  description = "Purpose tag for the Nodes"
  type = string
}
variable "eks"{
    description = "Details of Bastion Server"  
    type = object({
    version        = string,
    desired        = number,
    max            = number,
    min            = number,
    storage        = number,
    ami            = string
  })
}
variable "ng-name" {

}
variable "ng-type" {

}

variable "ng-lt" {}

variable "eks-labels" {
  description = "eks labels"
  type = list(string)
}

variable "elb-waf-policy-name" {}

variable "eks_name" {}

variable "ng-lt1"{}

variable "ng-name-app-cluster"{}

variable "eks-ng-subnet2"{}