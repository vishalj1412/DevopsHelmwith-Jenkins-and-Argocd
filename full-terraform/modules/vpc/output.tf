
output "VPC" {
  value = aws_vpc.VPC.id
}
output "Public-Subnet-1" {
  value = aws_subnet.Public-Subnet-1.id
}
output "Public-Subnet-2" {
  value = aws_subnet.Public-Subnet-2.id
}
# output "Public-Subnet-3" {
#   value = aws_subnet.Public-Subnet-3.id
# }
output "Private-Subnet-1" {
  value = aws_subnet.Private-Subnet-1.id
}
output "Private-Subnet-2" {
  value = aws_subnet.Private-Subnet-2.id
}
 output "Private-Subnet-3" {
   value = aws_subnet.Private-Subnet-3.id
 }

  output "Private-Subnet-4" {
   value = aws_subnet.Private-Subnet-4.id
 }
  output "Private-Subnet-5" {
   value = aws_subnet.Private-Subnet-5.id
 }
   output "Private-Subnet-6" {
   value = aws_subnet.Private-Subnet-6.id
 }
   output "Private-Subnet-7" {
   value = aws_subnet.Private-Subnet-7.id
 }

 
output "DB-Subnet-1" {
  value = aws_subnet.DB-Subnet-1.id
}
output "DB-Subnet-2" {
  value = aws_subnet.DB-Subnet-2.id
}
# output "DB-Subnet-3" {
#   value = aws_subnet.DB-Subnet-2.id
# }
# output "VPC-S3" {
#   value = aws_vpc_endpoint.VPC-S3.id
# }

#output "KMS" {
#  value = aws_kms_key.KMS.arn
#}
#output "kmsid" {
#  value = aws_kms_key.KMS.id
#}
