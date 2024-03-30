variable "region" {
  description = "The Region of Operation"
  type = string
}
variable "env" {
  description = "Name & Envionment of the en"
  type = string
}
variable "account" {
  description = "Account ID"
  type = number
}
variable "cidr" {
  description = "CIDR for VPC and Subnets"  
  type = object({
    vpc                 = string,
    Public-Subnet-1     = string,
    Public-Subnet-2     = string,
    #Public-Subnet-3     = string,
    Private-Subnet-1    = string,
    Private-Subnet-2    = string,
    Private-Subnet-3    = string,
    Private-Subnet-4    = string,
    Private-Subnet-5    = string,
    Private-Subnet-6    = string,
    Private-Subnet-7   = string,
    DB-Subnet-1         = string,
    DB-Subnet-2         = string,
    #DB-Subnet-3         = string
  })
}
variable"peering_id"{}
variable"peering_cidr"{}
# variable "flow-log-role" {
#  description = "Flow Log Role ARN"
#  type = string
# }
# variable "flow-log-group" {
#  description = "Cloudwatch Flow Log Group ARN"
#  type = string
# }

variable "Retention" {
  description = "log group retention period"
  type = number
}


# variable "kms_key_id" {}

 variable "eks_name" {}
  

