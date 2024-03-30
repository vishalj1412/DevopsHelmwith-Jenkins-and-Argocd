#####  VPC Flow-log Log Group  #####
resource "aws_cloudwatch_log_group" "Flowlog-Log-group" {
  name = "${var.env}-VPC-Flow-Log"
  retention_in_days = var.Retention
  #kms_key_id = var.kms_key_id
}
