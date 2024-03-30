



data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# data "aws_security_group" "ingress_sg" {
#   name = "${var.os["env"]}-${var.os["sg"]["ingress_sg_name"]}"
# }
