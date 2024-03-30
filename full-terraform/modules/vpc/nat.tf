#####  NAT Gateway  #####
resource "aws_eip" "eip-nat" {
  vpc = true
  tags = {    
            Name = "${var.env}-EIP-NAT"
          }
}
resource "aws_nat_gateway" "nat" { 
     allocation_id = aws_eip.eip-nat.id 
     subnet_id     = aws_subnet.Public-Subnet-1.id
     depends_on = [aws_internet_gateway.IGW]
     tags = {    
            Name = "${var.env}-NATGW"
          }
}
