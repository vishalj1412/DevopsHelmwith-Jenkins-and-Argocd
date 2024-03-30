data "aws_caller_identity" "current" {}

resource "aws_sns_topic" "config_sns_topic" {
  display_name = "${var.client}-Config-SNSTopic"
  name         = "${var.client}-Config-SNSTopic"

  tags = {
    Name = var.client
  }
}

resource "aws_sns_topic_policy" "config_sns_topic_policy" {
  depends_on = [
    aws_sns_topic.config_sns_topic
  ]

  policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Sid = "AWSSNSPolicy",
        Principal = {
          Service = [
            "config.amazonaws.com"
          ]
        },
        Effect   = "Allow",
        Action   = "sns:Publish",
        Resource = "${aws_sns_topic.config_sns_topic.arn}"
      }
    ]
  })

  arn = aws_sns_topic.config_sns_topic.arn
}

 resource "aws_sns_topic_subscription" "config_sns_subscription" {
   topic_arn = aws_sns_topic.config_sns_topic.arn
   for_each  = toset(["om.bhayani@truemeds.in", "pratik.falke@truemeds.in"])
   endpoint  =  each.value
   protocol  = "email"
 }

resource "aws_s3_bucket" "config_delivery_s3_bucket" {
  bucket_prefix = "truemeds-config-awsconfig-bucket"
  force_destroy = false

  tags = {
    Name = var.client
  }
}


resource "aws_s3_bucket_policy" "config_delivery_s3_bucket_policy" {
  bucket = aws_s3_bucket.config_delivery_s3_bucket.id
  depends_on = [
    aws_s3_bucket.config_delivery_s3_bucket
  ]
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AWSConfigBucketPermissionsCheck",
        Effect = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        },
        Action   = "s3:GetBucketAcl",
        Resource = "arn:aws:s3:::${aws_s3_bucket.config_delivery_s3_bucket.bucket}"
      },
      {
        Sid    = "AWSConfigBucketExistenceCheck",
        Effect = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        },
        Action   = "s3:ListBucket",
        Resource = "arn:aws:s3:::${aws_s3_bucket.config_delivery_s3_bucket.bucket}"
      },
      {
        Sid    = "AWSConfigBucketDelivery",
        Effect = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        },
        Action   = "s3:PutObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.config_delivery_s3_bucket.bucket}/*"
      }
    ]
  })
}

resource "aws_iam_service_linked_role" "config_service_linked_role" {
  aws_service_name = "config.amazonaws.com"
}

resource "aws_config_configuration_recorder" "configuration_recorder" {
  name = "${var.client}-configuration-recorder"
  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
  role_arn = aws_iam_service_linked_role.config_service_linked_role.arn
}

resource "aws_config_configuration_recorder_status" "configuration_recorder_status" {
  name       = aws_config_configuration_recorder.configuration_recorder.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.config_delivery_channel]
}

resource "aws_config_delivery_channel" "config_delivery_channel" {
  name           = "default"
  s3_bucket_name = aws_s3_bucket.config_delivery_s3_bucket.bucket
  s3_key_prefix  = aws_s3_bucket.config_delivery_s3_bucket.bucket_prefix
  sns_topic_arn  = aws_sns_topic.config_sns_topic.arn
  depends_on     = [aws_config_configuration_recorder.configuration_recorder]
}

resource "aws_config_config_rule" "config_rules" {
  for_each    = var.config_rules
  name        = "${var.client}-${each.key}"
  description = each.value.description
  depends_on = [
    aws_config_configuration_recorder_status.configuration_recorder_status
  ]
  scope {
    compliance_resource_types = each.value.compliance_resource_types
  }
  source {
    owner             = each.value.owner
    source_identifier = each.value.source_identifier
  }
  input_parameters            = each.value.input_parameters
  maximum_execution_frequency = each.value.maximum_execution_frequency

  tags = {
    Name = var.client
  }
}
