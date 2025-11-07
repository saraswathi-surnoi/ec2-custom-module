output "instance_public_ips" {
  description = "Public IPs of EC2 instances"
  value       = { for k, inst in aws_instance.ec2_instances : k => inst.public_ip }
}

output "instance_private_ips" {
  description = "Private IPs of EC2 instances"
  value       = { for k, inst in aws_instance.ec2_instances : k => inst.private_ip }
}

output "instance_ids" {
  description = "Instance IDs of created EC2s"
  value       = { for k, inst in aws_instance.ec2_instances : k => inst.id }
}
