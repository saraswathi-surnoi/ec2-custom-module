
output "sg_map" {
  value = { for k, v in aws_security_group.sg : k => v.id }
}


