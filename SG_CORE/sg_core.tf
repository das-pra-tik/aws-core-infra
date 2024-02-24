#tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group" "core_services_linux" {
  name        = "SG-${upper(var.env)}-CORE-LINUX-${var.region}"
  description = "Security-group-for-core-services"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.core_services_linux_ingress_rules
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidrs"]
    }
  }

  dynamic "egress" {
    for_each = var.core_services_linux_egress_rules
    content {
      description = egress.value["description"]
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidrs"]
    }
  }

  tags = merge(
    local.common_tags,
    {
      "Name" = "SG-${upper(var.env)}-CORE-LINUX-${var.region}"
    }
  )
}

#tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group" "core_services_windows" {
  name        = "SG-${upper(var.env)}-CORE-WINDOWS-${var.region}"
  description = "Security-group-for-core-services"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.core_services_windows_ingress_rules
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidrs"]
    }
  }

  dynamic "egress" {
    for_each = var.core_services_windows_egress_rules
    content {
      description = egress.value["description"]
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidrs"]
    }
  }

  tags = merge(
    local.common_tags,
    {
      "Name" = "SG-${upper(var.env)}-CORE-WINDOWS-${var.region}"
    }
  )
}