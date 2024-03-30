output "configuration_recorder" {
  value = aws_config_configuration_recorder.configuration_recorder.id
}

output "config_delivery_s3_bucket" {
  value = aws_s3_bucket.config_delivery_s3_bucket.bucket
}
