variable "prefix" {}

variable "env" {}

variable "cloudwatch_log_group_name" {
  type = string
}

variable "cloudwatch_notification_topic" {
  type = string
}

variable "sns_subscription_email" {
  type = string
}

variable "log_metric_filters" {
  type = map(object({
    pattern = string
  }))
}

variable "log_metric_filters_common" {
  type = object({
    namespace = string,
    value     = string
  })
}

variable "best_practices_alarms_common" {
  type = object({
    actions_enabled     = bool,
    namespace           = string,
    statistic           = string,
    dimensions          = map(string),
    period              = number,
    evaluation_periods  = number
    threshold           = map(string)
    comparison_operator = string
    treat_missing_data  = string
  })
}

variable "best_practices_alarms" {
  type = map(object({
    alarm_description = string
    metric_name       = string
  }))
}

# variable "s3_alarms_common" {
#   type = object({
#     metric_name         = string
#     alarm_description   = string
#     actions_enabled     = bool
#     namespace           = string
#     statistic           = string
#     period              = string
#     evaluation_periods  = number
#     threshold           = number
#     comparison_operator = string
#     treat_missing_data  = string
#   })
# }

# variable "s3_buckets" {
#   type = set(string)
# }

# variable "lambda_alarms_common" {
#   type = object({
#     metric_name         = string
#     alarm_description   = string
#     actions_enabled     = bool
#     namespace           = string
#     statistic           = string
#     period              = string
#     evaluation_periods  = number
#     threshold           = number
#     comparison_operator = string
#     treat_missing_data  = string
#   })
# }

# variable "lambda_functions" {
#   type = set(string)
# }

# variable "rds_alarms_common" {
#   type = object({
#     actions_enabled    = bool
#     namespace          = string
#     statistic          = string
#     period             = string
#     evaluation_periods = number
#     treat_missing_data = string
#     metrics            = map(object({
#       alarm_description   = string
#       threshold           = number
#       comparison_operator = string
#     }))
#   })
# }
# variable "rds_databases" {
#   type = set(string)
# }

# variable "cognito_alarms_common" {
#   type = object({
#     alarm_description     = string
#     metric_name           = string
#     actions_enabled       = bool
#     namespace             = string
#     period                = string
#     threshold             = number
#     evaluation_periods    = number
#     comparison_operator   = string
#     treat_missing_data    = string
#     expression_id         = string
#     expression            = string
#     label                 = string
#     expression_returndata = bool
#     query_returndata      = bool
#     query_id1             = string
#     query_id2             = string
#     stat1                 = string
#     stat2                 = string
#     unit                  = string
#   })
# }

# variable "cognito_signinfailures_alarms" {
#   type = map(object({
#     userpoolclient = string
#   }))
# }

