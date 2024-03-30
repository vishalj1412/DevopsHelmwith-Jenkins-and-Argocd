# locals {
#   lambda_alarms = var.guardduty_to_acl_lambda != null && var.prune_old_entries_lambda != null ? merge(var.lambda_alarms, {
#     (var.guardduty_to_acl_lambda) = {}
#     (var.prune_old_entries_lambda) = {}
#   }) : var.lambda_alarms

#   s3_alarms = var.config_delivery_s3_bucket != null ? merge(var.s3_alarms, {
#     (var.config_delivery_s3_bucket) = {
#       storagetype = "StandardStorage"    
#     }
#   }) : var.s3_alarms
# }

resource "aws_sns_topic" "cloudwatch_notifications" {
  display_name = "${var.prefix}-${var.cloudwatch_notification_topic}"
  name         = "${var.prefix}-${var.cloudwatch_notification_topic}"

  tags = {
    Name        = "${var.prefix}-${var.cloudwatch_notification_topic}"
    Environment = var.env
      }
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  depends_on = [
    aws_sns_topic.cloudwatch_notifications
  ]
  policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Sid = "AWSSNSPolicy",
        Principal = {
          Service = [
            "cloudwatch.amazonaws.com",
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ]
        },
        Effect   = "Allow",
        Action   = "sns:Publish",
        Resource = "${aws_sns_topic.cloudwatch_notifications.arn}"
      }
    ]
  })

  arn = aws_sns_topic.cloudwatch_notifications.arn
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.cloudwatch_notifications.arn
  endpoint  = var.sns_subscription_email
  protocol  = "email"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "/${var.prefix}/${var.cloudwatch_log_group_name}"

  tags = {
    Name        = "${var.prefix}-${var.cloudwatch_log_group_name}"
    Environment = var.env
    }
}
