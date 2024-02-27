######################################################
### AWS NETWORK FIREWALL
### Resource blocks for creating aws network firewall&
### Firewall Policy and Whitlisted Domains & cloudwatch logs
######################################################

resource "aws_networkfirewall_firewall" "firewall" {
  name = "egress-firewall"
  subnet_mapping {
    subnet_id = var.firewall_subnet # Replace with your subnet ID
    ip_address_type = var.ip_address_type
  }

  firewall_policy_arn = aws_networkfirewall_firewall_policy.firewall_policy.arn
  vpc_id             = var.ngw_vpc_id
}

resource "aws_networkfirewall_firewall_policy" "firewall_policy" {
  name = "firewall-policy"

  firewall_policy {
    stateless_default_actions            = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions  = ["aws:forward_to_sfe"]

    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.allow_domains.arn
    }

    }
}

resource "aws_networkfirewall_rule_group" "allow_domains" {
  capacity = 10
  name     = "allow-domains"
  type     = "STATEFUL"

  rule_group {
    rule_variables {
      ip_sets {
        key = "HOME_NET"
        ip_set {
          definition = var.ip_set_definition
        }
      }
    }
    rules_source {
      rules_source_list {
        generated_rules_type = var.generated_rules_type
        target_types         = var.target_types
        #targets              = toset(split("\n", file(var.targets_file)))
        targets = toset([for line in split("\n", file(var.targets_file)) : trimspace(line)])
      }
    }
  }
}

resource "aws_cloudwatch_log_group" "alerts" {
  name = "Firewall-Alerts"
}

resource "aws_networkfirewall_logging_configuration" "example" {
  firewall_arn = aws_networkfirewall_firewall.firewall.arn
  logging_configuration {
    log_destination_config {
      log_destination = {
        logGroup = aws_cloudwatch_log_group.alerts.name
      }
      log_destination_type = "CloudWatchLogs"
      log_type             = "ALERT"
    }
  }
}
