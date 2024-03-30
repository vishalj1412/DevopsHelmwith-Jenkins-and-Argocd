# ### S3 Bucket For CF ### 

resource "aws_s3_bucket" "CF-S3" {
  bucket = lower("${var.env}-${var.client}-cf-bucket")
  force_destroy = true
}

# ### BUCKET ACL FOR CF S3 ##



# # Block public access for CF S3 ###
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.CF-S3.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

# # ### Create S3 website hosting for CF ###
resource "aws_s3_bucket_website_configuration" "s3-hosting" {
  bucket = aws_s3_bucket.CF-S3.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# #  Bucket policy for CF S3

resource "aws_s3_bucket_policy" "cf-s3-policy" {
  bucket = aws_s3_bucket.CF-S3.id
  depends_on = [
    aws_s3_bucket.CF-S3
  ]
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
         {
            "Sid": "2",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_cloudfront_origin_access_identity.cf-oai.iam_arn}"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.CF-S3.arn}/*"
        }
    ]
}
POLICY
lifecycle {
    ignore_changes = all
  }
}

### Cloudfront OAI 

resource "aws_cloudfront_origin_access_identity" "cf-oai" {
  comment = "${var.client}-${var.env}-cf"
}