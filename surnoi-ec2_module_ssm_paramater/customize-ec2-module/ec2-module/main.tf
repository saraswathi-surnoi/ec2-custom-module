
resource "aws_instance" "ec2_instances" {
  for_each = var.instances

  ami                         = var.ami_id
  instance_type               = each.value.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = [lookup(var.sg_map, each.value.security_group_ref)]
  iam_instance_profile        = lookup(each.value, "iam_instance_profile", null)
  user_data                   = lookup(each.value, "user_data", null) != null ? file(each.value.user_data) : null

  root_block_device {
    volume_size = each.value.volume_size
    volume_type = lookup(each.value, "volume_type", "gp3")
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-${each.key}"
    Project     = var.project_name
    Environment = var.environment
  })
}


resource "aws_route53_record" "dns_records" {
  for_each = var.create_dns ? aws_instance.ec2_instances : {}

  zone_id = var.route53_zone_id
  name    = "${each.key}.${var.project_name}.${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [each.value.public_ip]
}
