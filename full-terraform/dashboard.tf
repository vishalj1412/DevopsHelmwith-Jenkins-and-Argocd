resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = local.name

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/ElastiCache",
              "CPUUtilization",
              "CacheClusterId",
               var.cluster_id
            ]
          ]
          period = var.period
          stat   = var.stat
          region = var.region
          title  = "${local.title}-CPU-utilization"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/ElastiCache",
              "CacheHitRate",
              "CacheClusterId",
               var.cluster_id
            ]
          ]
          period = var.period
          stat   = var.stat
          region = var.region
          title  = "${local.title}-Cache-hit-rate"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/ElastiCache",
              "ReplicaLag",
              "CacheClusterId",
              var.cluster_id
            ]
          ]
          period = var.period
          stat   = var.stat
          region = var.region
          title  = "${local.title}-replica-lag"
        }
      },
            {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/ElastiCache",
              "CurrConnections",
              "CacheClusterId",
              var.cluster_id
            ]
          ]
          period = var.period
          stat   = var.stat
          region = var.region
          title  = "${local.title}-Curr-Connections"
        }
      }

    ]
}) 
}


variable "period"{
  default = 300
}

variable "stat"{
  default = "Average"
}

variable "region"{
  default = "ap-south-1"
}

variable "instance_id"{
  default = "devkongdb"
}

locals {
  name = "sample-dashboard"
  title = "sample-title"
}

