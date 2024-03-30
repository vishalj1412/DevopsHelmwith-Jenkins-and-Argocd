### OpenSearch SG ###

resource "aws_security_group" "os-sg" {
    name = "${var.os["env"]}-${var.os["sg"]["sg_name"]}"
    description = "${var.os["env"]}-${var.os["sg"]["sg_name"]}"
    vpc_id = var.vpc_id
    
    ingress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks  = [var.os["sg"]["sg_ingress_cidr_block"]]
    }
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }   

    tags = {
      "Name" = "${var.os["env"]}-${var.os["domain_name"]}-sg"
    }
}