resource "aws_s3_bucket" "cloudfront-log" {
  bucket = lower("${var.env}-${var.client}cloudfront-log-bucket")
  force_destroy = true
}



resource "aws_s3_bucket_server_side_encryption_configuration" "cloudfront-log" {
  bucket = aws_s3_bucket.cloudfront-log.bucket

  rule {
  bucket_key_enabled = true
  apply_server_side_encryption_by_default {
    sse_algorithm = "aws:kms"
  }
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "cloudfront-log" {
  bucket = aws_s3_bucket.cloudfront-log.bucket
  rule {
    id = "deleting-after-${var.Retention}-days"
    expiration {
      days = var.Retention
    }
    status = "Enabled"
  }
}
resource "aws_s3_bucket_logging" "cloudfront-log" {
  bucket = aws_s3_bucket.cloudfront-log.id
  target_bucket = aws_s3_bucket.cloudfront-log.id
  target_prefix = lower("${var.env}-${var.client}logging-bucket/")
}
resource "aws_s3_bucket_object" "cloudfront-log" {
  bucket = aws_s3_bucket.cloudfront-log.bucket
  key    = lower("${var.env}-${var.client}cloudfront-log-bucket")
}
resource "aws_s3_bucket_policy" "cloudfront-log" {
  bucket = aws_s3_bucket.cloudfront-log.bucket
  depends_on = [
    aws_s3_bucket.cloudfront-log
  ]
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "${aws_s3_bucket.cloudfront-log.arn}",
                "${aws_s3_bucket.cloudfront-log.arn}/*"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
POLICY
}
