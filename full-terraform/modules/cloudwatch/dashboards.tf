# locals {
#   # Values need to be adjusted according to number of alarms
#   common_dashboard = [
#     [0, 0], [6, 0], [12, 0], [18, 0],
#     [0, 6], [6, 6], [12, 6], [18, 6],
#     [0, 12], [6, 12], [12, 12], [18, 12],
#     [0, 18], [6, 12], [12, 18], [18, 18],
#     [0, 24], [6, 12], [12, 24], [24, 24]
#   ]

#   rds_metric_alarms = flatten([
#     [
#       for alarm in aws_cloudwatch_metric_alarm.rds_freeablememory_alarms : alarm
#     ],
#     [
#       for alarm in aws_cloudwatch_metric_alarm.rds_networkreceivethroughput_alarms : alarm
#     ],
#     [
#       for alarm in aws_cloudwatch_metric_alarm.rds_databaseconnections_alarms : alarm
#     ],
#     [
#       for alarm in aws_cloudwatch_metric_alarm.rds_cpuutilization_alarms : alarm
#     ]
#   ])


#   best_practices_alarms = flatten([
#     for alarm in aws_cloudwatch_metric_alarm.best_practices_alarms : [
#       alarm
#     ]
#   ])
# }

# resource "aws_cloudwatch_dashboard" "rds_alarms_dashboard" {
#   dashboard_name = "${var.prefix}-rds-dashboard"
#   dashboard_body = jsonencode({
#     widgets = [
#       for i in range(length(local.rds_metric_alarms)) : {
#         height = 6,
#         width  = 6,
#         x      = local.common_dashboard[i][0],
#         y      = local.common_dashboard[i][1],
#         type   = "metric",
#         properties = {
#           title = local.rds_metric_alarms[i].alarm_name,
#           annotations = {
#             alarms = [
#               local.rds_metric_alarms[i].arn
#             ]
#           },
#           view    = "timeSeries",
#           stacked = false,
#           type    = "chart"
#         }
#       }
#     ]
#   })
# }

# resource "aws_cloudwatch_dashboard" "best_practices_alarms_dashboard" {
#   dashboard_name = "${var.prefix}-best-practices-dashboard"

#   dashboard_body = jsonencode({
#     widgets = [
#       for i in range(length(local.best_practices_alarms)) : {
#         height = 6,
#         width  = 6,
#         x      = local.common_dashboard[i][0],
#         y      = local.common_dashboard[i][1],
#         type   = "metric",
#         properties = {
#           title = local.best_practices_alarms[i].alarm_name,
#           annotations = {
#             alarms = [
#               local.best_practices_alarms[i].arn
#             ]
#           },
#           view    = "timeSeries",
#           stacked = false,
#           type    = "chart"
#         }
#       }
#     ]
#   })
# }