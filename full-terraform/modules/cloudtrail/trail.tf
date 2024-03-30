data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "cloudtrail" {
  name                          = "${var.prefix}-trails"
  s3_bucket_name                = aws_s3_bucket.s3-cloudtrail-logs-bucket.id
  include_global_service_events = "${var.include_global_service_events}"
  enable_log_file_validation = "${var.enable_log_file_validation}"
  kms_key_id                    = var.kms_key_id
  tags = {
    "Name" = "${var.prefix}-${var.env}-trails"
  }
}


resource "aws_s3_bucket" "s3-cloudtrail-logs-bucket" {
  bucket        = "${var.prefix}-${var.env}-cloudtrail"
  force_destroy = "${var.force_destroy_bucket}"
  tags = {
    "Name" = "${var.prefix}-${var.env}-cloudtrail-bucket"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = "${aws_s3_bucket.s3-cloudtrail-logs-bucket.id}"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement":  [
      {
        "Effect": "Allow",
        "Principal":  {
          "Service": "cloudtrail.amazonaws.com"
        },
        "Action": "s3:GetBucketAcl",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.s3-cloudtrail-logs-bucket.id}"
      },
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "cloudtrail.amazonaws.com"
        },
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.s3-cloudtrail-logs-bucket.id}/*",
        "Condition": {
          "StringEquals": {
            "s3:x-amz-acl": "bucket-owner-full-control"
          }
        }
      }
   ]
}
POLICY
}

