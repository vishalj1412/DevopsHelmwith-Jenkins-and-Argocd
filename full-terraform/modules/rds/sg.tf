resource "aws_security_group" "db_sg" {
  name = "${var.env}-db-sg"
  description = "Security group for db server"
  vpc_id = var.vpc

  ingress {
    from_port = "3306"
    to_port = "3306"
    protocol = "tcp"
    cidr_blocks = var.db_cidr
  }
  ingress {
    from_port = "5432"
    to_port = "5432"
    protocol = "tcp"
    cidr_blocks = var.db_cidr
  }
  egress {
    description = "Allow all outbound traffic"
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-db-sg"
  }
}


