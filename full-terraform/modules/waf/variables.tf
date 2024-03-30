variable "waf_web_acl" {
  type = object({
    name                       = string,
    description                = string,
    scope                      = string,
    cloudwatch_metrics_enabled = bool,
    sampled_requests_enabled   = bool
  })
}

variable "waf_web_acl_rulesets_common" {
  type = object({
    vendor_name                = string
    cloudwatch_metrics_enabled = bool
    sampled_requests_enabled   = bool
  })
}

variable "waf_web_acl_rulesets" {
  type = list(object({
    ruleset_name  = string,
    friendly_name = string,
    priority      = number
  }))
}

variable "prefix" {}

variable "env" {}
