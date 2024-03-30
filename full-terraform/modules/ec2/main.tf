
# Create the security groups
resource "aws_security_group" "web_sg" {
  name        = var.sg_name
  description = "Security group for web servers"
  vpc_id      = var.vpc_id_ec2
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 9600
    to_port     = 9600
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5044
    to_port     = 5044
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
     ingress {
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_ssh
  }
   ingress {
     from_port  = 8080
     to_port    = 8080
     protocol   = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
    ingress {
     from_port  = 9000
     to_port    = 9000
     protocol   = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example_instance" {
  count         = var.instance_count
  ami           = var.ami[count.index]
  instance_type = var.instance_type[count.index]
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name = var.key_name

  tags = {
     Name = "${element(var.instance_names, count.index)}"
  }
}
