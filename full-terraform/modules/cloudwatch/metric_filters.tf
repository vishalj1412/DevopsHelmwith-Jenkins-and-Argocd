resource "aws_cloudwatch_log_metric_filter" "log_metric_filters" {
  for_each = var.log_metric_filters

  name           = each.key
  pattern        = each.value.pattern
  log_group_name = aws_cloudwatch_log_group.log_group.name
  metric_transformation {
    name      = each.key
    namespace = var.log_metric_filters_common.namespace
    value     = var.log_metric_filters_common.value
  }
}