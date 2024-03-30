resource "aws_wafv2_web_acl" "waf_managed_rules" {
  name        = "${var.prefix}-${var.waf_web_acl.name}"
  description = var.waf_web_acl.description
  scope       = var.waf_web_acl.scope

  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = var.waf_web_acl_rulesets
    iterator = rule

    content {
      name     = rule.value.friendly_name
      priority = rule.value.priority

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.ruleset_name
          vendor_name = var.waf_web_acl_rulesets_common.vendor_name
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = var.waf_web_acl_rulesets_common.cloudwatch_metrics_enabled
        metric_name                = rule.value.ruleset_name
        sampled_requests_enabled   = var.waf_web_acl_rulesets_common.sampled_requests_enabled
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.waf_web_acl.cloudwatch_metrics_enabled
    metric_name                = "${var.prefix}-${var.waf_web_acl.name}"
    sampled_requests_enabled   = var.waf_web_acl.sampled_requests_enabled
  }

  tags = {
    Name        = "${var.prefix}-${var.waf_web_acl.name}"
    Environment = var.env
      }
}
