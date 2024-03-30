#####  Flow Log Role  #####
resource "aws_iam_role" "Flow-Log-Role" {
  name = "${var.env}-dev-VPC-Flow-Log-Role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}



#####  VPC Flow Policy  #####
resource "aws_iam_role_policy" "Flow-Log-Policy" {
  name = "${var.env}-dev-Flow-Log-Policy"
  role = aws_iam_role.Flow-Log-Role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:DeleteLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
