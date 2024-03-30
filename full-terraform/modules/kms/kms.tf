#####  KMS  #####
resource "aws_kms_key" "KMS" {
  description = "${var.env}-KMS-Key"
  enable_key_rotation = true
  multi_region = true
  deletion_window_in_days = 7
  policy = jsonencode(
{
"Version": "2012-10-17",
"Id": "key-default-1",
"Statement": [
{
"Sid": "Enable IAM User Permissions",
"Effect": "Allow",
"Principal": {
"AWS": [
"*"
],
"Service": [
"rds.amazonaws.com",
"ec2.amazonaws.com",
"autoscaling.amazonaws.com",
"eks.amazonaws.com"
#"elasticache.amazonaws.com"
]
},
"Action": "kms:*",
"Resource": "*"
}
]
}
)
  tags = {
    Name = "${var.env}-KMS"
  }
}
resource "aws_kms_alias" "KMS" {
  name          = "alias/${var.env}-KMS-Key"
  target_key_id = aws_kms_key.KMS.key_id
}
