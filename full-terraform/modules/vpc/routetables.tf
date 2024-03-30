#####  Route Tables & Association #####
resource "aws_route_table" "Public-RT" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
   }
    tags = {
              Name = "${var.env}-Public-RT" 
          }
}
resource "aws_route_table_association" "Public-RTA-1" {
  route_table_id = aws_route_table.Public-RT.id
  subnet_id      = aws_subnet.Public-Subnet-1.id
}
resource "aws_route_table_association" "Public-RTA-2" {
  route_table_id = aws_route_table.Public-RT.id
  subnet_id      = aws_subnet.Public-Subnet-2.id
}
# resource "aws_route_table_association" "Public-RTA-3" {
#   route_table_id = aws_route_table.Public-RT.id
#   subnet_id      = aws_subnet.Public-Subnet-3.id
# }
resource "aws_route_table" "Private-RT" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
   }
  route {
    vpc_peering_connection_id = var.peering_id
    cidr_block                 = var.peering_cidr
  } 

    tags = {
              Name = "${var.env}-Private-RT" 
          }
}
resource "aws_route_table_association" "Private-RTA-1" {
  route_table_id = aws_route_table.Private-RT.id
  subnet_id      = aws_subnet.Private-Subnet-1.id
}

resource "aws_route_table_association" "DB-RTA-1" {
  route_table_id = aws_route_table.Private-RT.id
  subnet_id      = aws_subnet.DB-Subnet-1.id
}

resource "aws_route_table_association" "Private-RTA-2" {
  route_table_id = aws_route_table.Private-RT.id
  subnet_id      = aws_subnet.Private-Subnet-2.id
}
resource "aws_route_table_association" "DB-RTA-2" {
  route_table_id = aws_route_table.Private-RT.id
  subnet_id      = aws_subnet.DB-Subnet-2.id
}

# resource "aws_route_table" "Private-RT-1c" {
#   vpc_id = aws_vpc.VPC.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat1c.id
#    }
#     tags = {
#               Name = "${var.env}-Private-RT-1c" 
#           }
# }
resource "aws_route_table_association" "Private-RTA-3" {
   route_table_id = aws_route_table.Private-RT.id
   subnet_id      = aws_subnet.Private-Subnet-3.id
 }
resource "aws_route_table_association" "Private-RTA-4" {
   route_table_id = aws_route_table.Private-RT.id
   subnet_id      = aws_subnet.Private-Subnet-4.id
 }
 resource "aws_route_table_association" "Private-RTA-5" {
   route_table_id = aws_route_table.Private-RT.id
   subnet_id      = aws_subnet.Private-Subnet-5.id
 }
  resource "aws_route_table_association" "Private-RTA-6" {
   route_table_id = aws_route_table.Private-RT.id
   subnet_id      = aws_subnet.Private-Subnet-6.id
 }
  resource "aws_route_table_association" "Private-RTA-7" {
   route_table_id = aws_route_table.Private-RT.id
   subnet_id      = aws_subnet.Private-Subnet-7.id
 }
# resource "aws_route_table_association" "DB-RTA-3" {
#   route_table_id = aws_route_table.Private-RT-1c.id
#   subnet_id      = aws_subnet.DB-Subnet-3.id
# }
