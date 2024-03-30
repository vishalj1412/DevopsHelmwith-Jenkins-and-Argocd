
resource "aws_s3_bucket" "website" {  
  bucket = var.app_bucket_name
  object_lock_enabled         = false
    policy                      = jsonencode(
        {
            Id        = "PolicyForCloudFrontPrivateContent"
            Statement = [
                {
                    Action    = "s3:GetObject"
                    Condition = {
                        StringEquals = {
                            "AWS:SourceArn" = "*"
                        }
                    }
                    Effect    = "Allow"
                    Principal = {
                        Service = "cloudfront.amazonaws.com"
                    }
                    Resource  = "arn:aws:s3:::${var.app_bucket_name}/*"
                    Sid       = "AllowCloudFrontServicePrincipal"
                },
                {
                    Action    = [
                        "s3:GetObject",
                        "s3:GetObjectVersion",
                    ]
                    Effect    = "Allow"
                    Principal = "*"
                    Resource  = "arn:aws:s3:::${var.app_bucket_name}/*"
                    Sid       = "PublicRead"
                },
            ]
            Version   = "2008-10-17"
        }
    )


    versioning {
        enabled    = true
        mfa_delete = false
    }

    website {
        error_document = "error.html"
        index_document = "index.html"
    }


}

resource "aws_s3_bucket_acl" "website" {
  bucket = aws_s3_bucket.website.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "website-configuration" {
  bucket = aws_s3_bucket.website.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# AWS Cloudfront for caching
resource "aws_cloudfront_distribution" "s3_distribution" {

  depends_on = [
    aws_s3_bucket.website,
    aws_s3_bucket_website_configuration.website-configuration,
    aws_s3_bucket_acl.website
  ]
  origin {
    connection_attempts = 3
    connection_timeout  = 10
    domain_name = "${aws_s3_bucket.website.bucket}.s3.amazonaws.com"
    origin_id   = "${aws_s3_bucket.website.bucket}.s3.amazonaws.com"
  

}
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Managed by Terraform"
  default_root_object = "index.html"
  retain_on_delete               = false
  http_version                   = "http2"
  wait_for_deployment            = true

  custom_error_response {
        error_caching_min_ttl = 10
        error_code            = 404
        response_code         = 200
        response_page_path    = "/index.html"
    }

  

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS","PATCH","POST",
   "PUT","DELETE"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${aws_s3_bucket.website.bucket}.s3.amazonaws.com"
    cache_policy_id            = data.aws_cloudfront_cache_policy.managed_cloudfront_cache_policy.id
  

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
   
    smooth_streaming         = false
    
    trusted_key_groups       = []
    trusted_signers          = [] 

  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "dev"
    Name        = "Cachy-Website-CDN"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

data "aws_cloudfront_cache_policy" "managed_cloudfront_cache_policy" {
  name = "Managed-CachingOptimized"
}

