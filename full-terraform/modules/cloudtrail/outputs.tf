output "s3-cloudtrail-logs-bucket_id" {
  value = "${aws_s3_bucket.s3-cloudtrail-logs-bucket.id}"
}

output "cloudtrail_id" {
  value = "${aws_cloudtrail.cloudtrail.id}"
}
