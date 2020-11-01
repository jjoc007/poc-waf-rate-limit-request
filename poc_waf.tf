resource "aws_wafv2_ip_set" "poc_ipset" {
  name               = "ipset-waf-example"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = ["190.27.23.151/32"]
}

resource "aws_wafv2_web_acl" "poc_waf_web_acl" {
  name        = "rate-based-example"
  description = "Example of a rate based statement."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-limit-rate"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 100
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "poc_waf_web_acl_rule_metric"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "poc_waf_web_acl_metric"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_web_acl_association" "poc_web_acl_association" {
  resource_arn = aws_api_gateway_stage.poc_api_stage.arn
  web_acl_arn  = aws_wafv2_web_acl.poc_waf_web_acl.arn
}




