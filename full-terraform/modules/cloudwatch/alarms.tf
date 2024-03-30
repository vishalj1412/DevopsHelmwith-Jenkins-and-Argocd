resource "aws_cloudwatch_metric_alarm" "best_practices_alarms" {
  for_each = var.best_practices_alarms

  alarm_name        = "${var.prefix}-${each.key}-${each.value.metric_name}"
  alarm_description = each.value.alarm_description
  actions_enabled   = var.best_practices_alarms_common.actions_enabled
  alarm_actions = [
    aws_sns_topic.cloudwatch_notifications.arn
  ]
  metric_name         = each.value.metric_name
  namespace           = var.best_practices_alarms_common.namespace
  statistic           = var.best_practices_alarms_common.statistic
  dimensions          = var.best_practices_alarms_common.dimensions
  period              = var.best_practices_alarms_common.period
  evaluation_periods  = var.best_practices_alarms_common.evaluation_periods
  threshold           = lookup(var.best_practices_alarms_common.threshold, each.key, null) != null ? var.best_practices_alarms_common.threshold[each.key] : var.best_practices_alarms_common.threshold["Other"]
  comparison_operator = var.best_practices_alarms_common.comparison_operator
  treat_missing_data  = var.best_practices_alarms_common.treat_missing_data

  tags = {
    Name        = "${var.prefix}-${each.key}-${each.value.metric_name}"
    Environment = var.env
      }
}

# resource "aws_cloudwatch_metric_alarm" "rds_networkreceivethroughput_alarms" {
#   count = length(var.rds_databases)

#   alarm_name        = "${var.prefix}-${element(tolist(var.rds_databases), count.index)}-NetworkReceiveThroughput"
#   alarm_description = var.rds_alarms_common["metrics"]["NetworkReceiveThroughput"]["alarm_description"]
#   actions_enabled   = var.rds_alarms_common.actions_enabled
#   alarm_actions = [
#     aws_sns_topic.cloudwatch_notifications.arn
#   ]
#   metric_name = "NetworkReceiveThroughput"
#   namespace   = var.rds_alarms_common.namespace
#   statistic   = var.rds_alarms_common.statistic
#   dimensions = {
#     DBInstanceIdentifier = element(tolist(var.rds_databases), count.index)
#   }
#   period              = var.rds_alarms_common.period
#   evaluation_periods  = var.rds_alarms_common.evaluation_periods
#   threshold           = var.rds_alarms_common["metrics"]["NetworkReceiveThroughput"]["threshold"]
#   comparison_operator = var.rds_alarms_common["metrics"]["NetworkReceiveThroughput"]["comparison_operator"]
#   treat_missing_data  = var.rds_alarms_common.treat_missing_data

#   tags = {
#     Name        = "${var.prefix}-${element(tolist(var.rds_databases), count.index)}-NetworkReceiveThroughput"
#     Environment = var.env
#       }
# }

# resource "aws_cloudwatch_metric_alarm" "rds_cpuutilization_alarms" {
#   count = length(var.rds_databases)

#   alarm_name        = "${var.prefix}-${element(tolist(var.rds_databases), count.index)}-CPUUtilization"
#   alarm_description = var.rds_alarms_common["metrics"]["CPUUtilization"]["alarm_description"]
#   actions_enabled   = var.rds_alarms_common.actions_enabled
#   alarm_actions = [
#     aws_sns_topic.cloudwatch_notifications.arn
#   ]
#   metric_name = "CPUUtilization"
#   namespace   = var.rds_alarms_common.namespace
#   statistic   = var.rds_alarms_common.statistic
#   dimensions = {
#     DBInstanceIdentifier = element(tolist(var.rds_databases), count.index)
#   }
#   period              = var.rds_alarms_common.period
#   evaluation_periods  = var.rds_alarms_common.evaluation_periods
#   threshold           = var.rds_alarms_common["metrics"]["CPUUtilization"]["threshold"]
#   comparison_operator = var.rds_alarms_common["metrics"]["CPUUtilization"]["comparison_operator"]
#   treat_missing_data  = var.rds_alarms_common.treat_missing_data

#   tags = {
#     Name        = "${var.prefix}-${element(tolist(var.rds_databases), count.index)}-CPUUtilization"
#     Environment = var.env
#       }
# }

# resource "aws_cloudwatch_metric_alarm" "rds_databaseconnections_alarms" {
#   count = length(var.rds_databases)

#   alarm_name        = "${var.prefix}-${element(tolist(var.rds_databases), count.index)}-DatabaseConnections"
#   alarm_description = var.rds_alarms_common["metrics"]["DatabaseConnections"]["alarm_description"]
#   actions_enabled   = var.rds_alarms_common.actions_enabled
#   alarm_actions = [
#     aws_sns_topic.cloudwatch_notifications.arn
#   ]
#   metric_name = "DatabaseConnections"
#   namespace   = var.rds_alarms_common.namespace
#   statistic   = var.rds_alarms_common.statistic
#   dimensions = {
#     DBInstanceIdentifier = element(tolist(var.rds_databases), count.index)
#   }
#   period              = var.rds_alarms_common.period
#   evaluation_periods  = var.rds_alarms_common.evaluation_periods
#   threshold           = var.rds_alarms_common["metrics"]["DatabaseConnections"]["threshold"]
#   comparison_operator = var.rds_alarms_common["metrics"]["DatabaseConnections"]["comparison_operator"]
#   treat_missing_data  = var.rds_alarms_common.treat_missing_data

#   tags = {
#     Name        = "${var.prefix}-${element(tolist(var.rds_databases), count.index)}-DatabaseConnections"
#     Environment = var.env
#       }
# }

# resource "aws_cloudwatch_metric_alarm" "rds_freeablememory_alarms" {
#   count = length(var.rds_databases)

#   alarm_name        = "${var.prefix}-${element(tolist(var.rds_databases), count.index)}-FreeableMemory"
#   alarm_description = var.rds_alarms_common["metrics"]["FreeableMemory"]["alarm_description"]
#   actions_enabled   = var.rds_alarms_common.actions_enabled
#   alarm_actions = [
#     aws_sns_topic.cloudwatch_notifications.arn
#   ]
#   metric_name = "FreeableMemory"
#   namespace   = var.rds_alarms_common.namespace
#   statistic   = var.rds_alarms_common.statistic
#   dimensions = {
#     DBInstanceIdentifier = element(tolist(var.rds_databases), count.index)
#   }
#   period              = var.rds_alarms_common.period
#   evaluation_periods  = var.rds_alarms_common.evaluation_periods
#   threshold           = var.rds_alarms_common["metrics"]["FreeableMemory"]["threshold"]
#   comparison_operator = var.rds_alarms_common["metrics"]["FreeableMemory"]["comparison_operator"]
#   treat_missing_data  = var.rds_alarms_common.treat_missing_data

#   tags = {
#     Name        = "${var.prefix}-${element(tolist(var.rds_databases), count.index)}-FreeableMemory"
#     Environment = var.env
#       }
# }