output "sg_map" {
  description = "Map of all created security groups and their IDs"
  value       = { for k, v in aws_security_group.this : k => v.id }
}



