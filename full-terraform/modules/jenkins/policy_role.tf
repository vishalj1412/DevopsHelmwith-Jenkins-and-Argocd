#####  Jenkins-EC2-SSM Role  #####
resource "aws_iam_role" "EC2-SSM" {
  name = "prod-Jenkins-SSM-Ec2-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}



resource "aws_iam_role_policy_attachment" "EC2-SSM-Attach" {
  role      = aws_iam_role.EC2-SSM.name
  for_each = toset(["arn:aws:iam::aws:policy/AmazonS3FullAccess",
                "arn:aws:iam::aws:policy/CloudWatchFullAccess",
                "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
                "arn:aws:iam::aws:policy/CloudFrontFullAccess"])
  policy_arn = each.key
}

resource "aws_iam_instance_profile" "EC2-S3-SSM-CW-Profile" {
  name = "prod-Jenkins-EC2-S3-SSM-CW-Profile"
  role = aws_iam_role.EC2-SSM.name
}
