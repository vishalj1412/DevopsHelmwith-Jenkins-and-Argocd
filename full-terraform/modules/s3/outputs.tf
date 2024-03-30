output "CF-S3" {
    value = aws_s3_bucket.CF-S3.bucket
  
}

output "cf-s3-id" {
    value = aws_s3_bucket.CF-S3.id
  
}

output "CF-S3-domain" {
    value = aws_s3_bucket.CF-S3.bucket_regional_domain_name
  
}



output "oai" {
    value = aws_cloudfront_origin_access_identity.cf-oai.cloudfront_access_identity_path
  
}

# # output "config" {
# #     value = aws_s3_bucket.config.bucket
  
# # }

# output "alb" {
#     value = aws_s3_bucket.alb.bucket
  
# }

# # output "waf-cf" {
# #     value = aws_s3_bucket.waf-cf.bucket
  
# # }

# # output "waf-alb" {
# #     value = aws_s3_bucket.waf-alb.bucket
  
# # }