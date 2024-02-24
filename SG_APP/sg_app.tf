resource "aws_security_group" "this" {
  name        = "SG-${upper(var.environment)}-${upper(var.application_code)}-${upper(var.sec_grp_type)}-${var.region}"
  description = "Security group for ${upper(var.application_code)} with ${upper(var.sec_grp_type)} specific ports"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidrs"]
    }
  }

  ingress {
    description = "Self referancing SG"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    self        = true
  }

  tags = merge(
    local.common_tags, local.project_tags,
  )
}