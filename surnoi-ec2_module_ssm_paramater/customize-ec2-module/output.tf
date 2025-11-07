
##########################################################
# OUTPUTS — LOGISTICS PROJECT
##########################################################

output "project_info" {
  description = "Project and environment summary"
  value = {
    project_name = var.project_name
    environment  = var.environment
    aws_region   = var.aws_region
  }
}

##########################################################
# INSTANCE PUBLIC IPS
##########################################################
output "instance_public_ips" {
  description = "Public IPs of EC2 instances"
  value       = module.ec2_instances.instance_public_ips
}

##########################################################
# ROUTE53 RECORDS
##########################################################
output "route53_dns_records" {
  description = "DNS names of EC2 instances (if Route53 is enabled)"
  value = var.route53_zone_id != "" ? {
    for k, v in module.ec2_instances.instance_public_ips :
    k => "${k}.${var.project_name}.${var.environment}.${var.domain_name}"
  } : {}
}

##########################################################
# SUMMARY TABLE (Friendly Display)
##########################################################
output "instance_summary" {
  description = "Formatted table of instances, IPs, and DNS names"
  value = [
    for k, ip in module.ec2_instances.instance_public_ips : {
      instance_name = k
      public_ip     = ip
      dns_record    = (
        var.route53_zone_id != "" ?
        "${k}.${var.project_name}.${var.environment}.${var.domain_name}" :
        "N/A"
      )
    }
  ]
}


