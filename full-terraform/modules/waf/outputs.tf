output "waf_web_acl" {
  value = aws_wafv2_web_acl.waf_managed_rules.arn
}