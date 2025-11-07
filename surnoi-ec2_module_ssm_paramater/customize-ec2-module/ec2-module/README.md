EC2 + Route53 Module

This Terraform module provisions **EC2 instances** and optionally creates **Route53 DNS records** for each instance.  
It is designed to be reusable and consistent across environments (dev, qa, prod).

Features

- Dynamically creates multiple EC2 instances from a map input  
- Supports existing key pairs and IAM instance profiles  
- Automatically tags all resources with project and environment  
- Configurable root volume size and type  
- Integrates with your `sg-module` for security groups  
- Optionally creates Route53 DNS records for each EC2 instance  
- Outputs both public and private IPs  
- Validates allowed instance types (`t2.micro`, `t3.micro`, `t3.small`, `t3.medium`, `t3.large`)


