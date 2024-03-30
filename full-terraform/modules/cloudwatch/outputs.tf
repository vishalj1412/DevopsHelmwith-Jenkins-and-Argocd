output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.log_group.arn
}

output "sns_topic_subscription" {
  value = aws_sns_topic_subscription.sns_subscription.arn
}