resource "aws_cloudfront_origin_access_identity" "cf-customer" {
  comment = var.cf-customer
}
resource "aws_cloudfront_origin_access_identity" "cf-admin" {
  comment = var.cf-admin
}
resource "aws_cloudfront_distribution" "cf-s3" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.client}-Cloudfront-Distribution"
  default_root_object = "index.html"
  price_class         = "PriceClass_200"
  http_version        = "http2"
  viewer_certificate {
    cloudfront_default_certificate = true
    #acm_certificate_arn = var.cf-acm
  }

  origin {
    domain_name = var.customer-domain
    origin_id   = "S3-Origin"
    custom_origin_config {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols = ["TLSv1.2"]
    }
  }
  # origin {
  #   domain_name = var.custom-domain-alb
  #   origin_id   = var.custom-origin-alb
  #   custom_origin_config {
  #       http_port = 80
  #       https_port = 443
  #       origin_protocol_policy = "https-only"
  #       origin_ssl_protocols = ["TLSv1.2"]
  #   }
  # }
  # logging_config {
  #   include_cookies = false
  #   bucket          = "cloudfront-nv-dhanush.s3.amazonaws.com"
  # }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-Origin"
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/admin/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-Origin"
    forwarded_values {
      query_string = false
      headers      = []
      cookies {
        forward = "none"
      }
    }
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.cloudfront.arn
    }
  }
   restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

}


resource "aws_cloudfront_function" "cloudfront" {
  name    = "${var.client}-Cloudfront-Function"
  runtime = "cloudfront-js-1.0"
  comment = "${var.client}-Cloudfront-Function"
  publish = true
  code    = <<EOT

    function handler(event) {
    var request = event.request;
    var uri = request.uri;

    // Check whether the URI is missing a file name.
    if (uri.endsWith('/')) {
        request.uri += 'index.html';
    }
    // Check whether the URI is missing a file extension.
    else if (!uri.includes('.')) {
        request.uri += '/index.html';
    }

    return request;
  }
  EOT
}