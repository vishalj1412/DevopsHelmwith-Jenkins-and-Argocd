#####  Public Subnets #####
resource "aws_subnet" "Public-Subnet-1" {  
vpc_id                  = aws_vpc.VPC.id  
cidr_block              = var.cidr.Public-Subnet-1  
availability_zone       = "${var.region}a" 
map_public_ip_on_launch = true  
tags = {    
          Name = "${var.env}-Public-Subnet-1a",
          format("%s/%s","kubernetes.io/cluster", var.eks_name[0]) = "owned",
          format("%s/%s","kubernetes.io/cluster", var.eks_name[1]) = "owned",
          "kubernetes.io/role/elb" = 1
      }
}
resource "aws_subnet" "Public-Subnet-2" {  
vpc_id                  = aws_vpc.VPC.id  
cidr_block              = var.cidr.Public-Subnet-2  
availability_zone       = "${var.region}b" 
map_public_ip_on_launch = true 
tags = {    
          Name = "${var.env}-Public-Subnet-1b",
          format("%s/%s","kubernetes.io/cluster", var.eks_name[0]) = "owned",
          format("%s/%s","kubernetes.io/cluster", var.eks_name[1]) = "owned",
          "kubernetes.io/role/elb" = 1
      }
}
# resource "aws_subnet" "Public-Subnet-3" {  
# vpc_id                  = aws_vpc.VPC.id  
# cidr_block              = var.cidr.Public-Subnet-3  
# availability_zone       = "${var.region}c" 
# map_public_ip_on_launch = false 
# tags = {    
#           Name = "${var.env}-Public-Subnet-1c"
#       }
# }
#####  Private Subnets ##### 
resource "aws_subnet" "Private-Subnet-1" {  
vpc_id                  = aws_vpc.VPC.id  
cidr_block              = var.cidr.Private-Subnet-1  
availability_zone       = "${var.region}a" 
map_public_ip_on_launch = false  
tags = {    
          Name = "${var.env}-Private-Subnet-1a",
          format("%s/%s","kubernetes.io/cluster", var.eks_name[0]) = "owned",
          format("%s/%s","kubernetes.io/cluster", var.eks_name[1]) = "owned",
          "kubernetes.io/role/internal-elb" = 1
      }
}
resource "aws_subnet" "Private-Subnet-2" {  
vpc_id                  = aws_vpc.VPC.id  
cidr_block              = var.cidr.Private-Subnet-2  
availability_zone       = "${var.region}b" 
map_public_ip_on_launch = false  
tags = {    
          Name = "${var.env}-Private-Subnet-1b",
         format("%s/%s","kubernetes.io/cluster", var.eks_name[0]) = "owned",
         format("%s/%s","kubernetes.io/cluster", var.eks_name[1]) = "owned",
          "kubernetes.io/role/internal-elb" = 1
        
      }
}
 resource "aws_subnet" "Private-Subnet-3" {  
 vpc_id                  = aws_vpc.VPC.id  
 cidr_block              = var.cidr.Private-Subnet-3  
 availability_zone       = "${var.region}c" 
 map_public_ip_on_launch = false  
 tags = {    
           Name = "${var.env}-Private-Subnet-1c"
           format("%s/%s","kubernetes.io/cluster", var.eks_name[0]) = "owned",
           format("%s/%s","kubernetes.io/cluster", var.eks_name[1]) = "owned",
          "kubernetes.io/role/internal-elb" = 1
       }
 }
  resource "aws_subnet" "Private-Subnet-4" {  
 vpc_id                  = aws_vpc.VPC.id  
 cidr_block              = var.cidr.Private-Subnet-4 
 availability_zone       = "${var.region}c" 
 map_public_ip_on_launch = false  
 tags = {    
           Name = "${var.env}-Private-Subnet-1c",
           format("%s/%s","kubernetes.io/cluster", var.eks_name[0]) = "owned",
           format("%s/%s","kubernetes.io/cluster", var.eks_name[1]) = "owned",
          "kubernetes.io/role/internal-elb" = 1
       }
 }
  resource "aws_subnet" "Private-Subnet-5" {  
 vpc_id                  = aws_vpc.VPC.id  
 cidr_block              = var.cidr.Private-Subnet-5 
 availability_zone       = "${var.region}b" 
 map_public_ip_on_launch = false  
 tags = {    
           Name = "${var.env}-Private-Subnet-1b",
           format("%s/%s","kubernetes.io/cluster", var.eks_name[0]) = "owned",
           format("%s/%s","kubernetes.io/cluster", var.eks_name[1]) = "owned",
          "kubernetes.io/role/internal-elb" = 1
       }
 }
  resource "aws_subnet" "Private-Subnet-6" {  
 vpc_id                  = aws_vpc.VPC.id  
 cidr_block              = var.cidr.Private-Subnet-6
 availability_zone       = "${var.region}b" 
 map_public_ip_on_launch = false  
 tags = {    
           Name = "${var.env}-Private-Subnet-1b",
           format("%s/%s","kubernetes.io/cluster", var.eks_name[1]) = "owned",
          "kubernetes.io/role/internal-elb" = 1
       }
 }

   resource "aws_subnet" "Private-Subnet-7" {  
 vpc_id                  = aws_vpc.VPC.id  
 cidr_block              = var.cidr.Private-Subnet-7
 availability_zone       = "${var.region}c" 
 map_public_ip_on_launch = false  
 tags = {    
           Name = "${var.env}-Private-Subnet-1c",
           format("%s/%s","kubernetes.io/cluster", var.eks_name[1]) = "owned",
          "kubernetes.io/role/internal-elb" = 1
       }
 }

resource "aws_subnet" "DB-Subnet-1" {  
vpc_id                  = aws_vpc.VPC.id  
cidr_block              = var.cidr.DB-Subnet-1  
availability_zone       = "${var.region}a" 
map_public_ip_on_launch = false  
tags = {    
          Name = "${var.env}-DB-Subnet-1a",
         format("%s/%s","kubernetes.io/cluster", var.eks_name[0]) = "owned",
         format("%s/%s","kubernetes.io/cluster", var.eks_name[1]) = "owned",
          "kubernetes.io/role/internal-elb" = 1
      }
}
resource "aws_subnet" "DB-Subnet-2" {  
vpc_id                  = aws_vpc.VPC.id  
cidr_block              = var.cidr.DB-Subnet-2  
availability_zone       = "${var.region}b" 
map_public_ip_on_launch = false  
tags = {    
          Name = "${var.env}-DB-Subnet-1b",
          format("%s/%s","kubernetes.io/cluster", var.eks_name[0]) = "owned",
          format("%s/%s","kubernetes.io/cluster", var.eks_name[1]) = "owned",
          "kubernetes.io/role/internal-elb" = 1
      }
}
# resource "aws_subnet" "DB-Subnet-3" {  
# vpc_id                  = aws_vpc.VPC.id  
# cidr_block              = var.cidr.DB-Subnet-3  
# availability_zone       = "${var.region}c" 
# map_public_ip_on_launch = false  
# tags = {    
#           Name = "${var.env}-DB-Subnet-1c"
#       }
# }
