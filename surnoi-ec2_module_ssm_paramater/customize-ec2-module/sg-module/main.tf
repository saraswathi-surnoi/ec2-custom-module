resource "aws_security_group" "sg" {
  for_each = var.security_groups

  name        = "${var.project_name}-${var.environment}-${each.key}-sg"
  description = each.value.description
  vpc_id      = var.vpc_id

  # Dynamic ingress rules
  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Dynamic egress rules
  dynamic "egress" {
    for_each = each.value.egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  # Tags
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-${each.key}-sg"
  })
}

