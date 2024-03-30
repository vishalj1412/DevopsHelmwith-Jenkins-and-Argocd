variable "client" {
  description = "Name & Envionment of the client(XYZ-Prod)"
  type = string
}

variable "cf-customer" {
  description = "S3 bucket for the distribution"
  type = string
}
variable "cf-admin" {
  description = "S3 bucket for the distribution"
  type = string
}
variable "customer-domain" {
  description = "S3 bucket for the distribution"
  type = string
}
variable "admin-domain" {
  description = "S3 bucket for the distribution"
  type = string
}

# variable "cf-acm" {
#   description = "ARN of WAF-Cloudfront-WEB-ACL"
#   type = string
# }
variable "Retention" {
  description = "Retentention Period for VPC Flow logs"
  type = number
}
variable "env" {
  description = "Environment for path"
  type = string
}