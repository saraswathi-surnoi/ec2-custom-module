output "instance_public_ips" {
  description = "Public IPs of EC2 instances"
  value       = { for k, v in aws_instance.ec2_instances : k => v.public_ip }
}
output "instance_private_ips" {
  description = "Private IPs of EC2 instances"
  value       = { for k, v in aws_instance.ec2_instances : k => v.private_ip }
}
output "dns_records" {
  description = "DNS names of instances (if created)"
  value = var.create_dns ? {
    for k, v in aws_instance.ec2_instances :
    k => "${k}.${var.project_name}.${var.environment}.${var.domain_name}"
  } : {}
}
