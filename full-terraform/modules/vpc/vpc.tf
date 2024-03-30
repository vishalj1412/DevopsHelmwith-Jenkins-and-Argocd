#####  VPC  #####
resource "aws_vpc" "VPC" { 
 cidr_block = var.cidr.vpc
 enable_dns_support = true
 enable_dns_hostnames = true
 tags = { 
          Name = "${var.env}-vpc" 
        }
}
resource "aws_flow_log" "VPC-FLow-log" {
  iam_role_arn    = aws_iam_role.Flow-Log-Role.arn
  log_destination = aws_cloudwatch_log_group.Flowlog-Log-group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.VPC.id
  tags = { 
          Name = "${var.env}-VPC-Flow-Log" 
        }
}
resource "aws_internet_gateway" "IGW" {  
   vpc_id = aws_vpc.VPC.id   
   tags = {    
            Name = "${var.env}-IGW"
          }
}
