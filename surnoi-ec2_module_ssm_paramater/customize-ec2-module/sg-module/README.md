🧱 Security Group Module (`sg-module`)

This Terraform module manages the creation of multiple **AWS Security Groups** and their associated ingress/egress rules.  
It is designed to work seamlessly with your EC2 and Route53 modules as part of the **Logistics MOT Project** infrastructure.

---

🚀 Features

- Dynamically creates multiple Security Groups from a single configuration map  
- Supports both **ingress** and **egress** rule definitions  
- Tags all resources automatically with project and environment metadata  
- Returns a map of created Security Group IDs for easy reference in other modules (e.g., EC2 module)  
- Enforces best practices by allowing only explicitly defined ports and CIDR blocks  

---


---

## ⚙️ Resources Created

| Resource Type | Description |
|----------------|-------------|
| `aws_security_group` | Creates a Security Group for each entry in the configuration map |
| `aws_security_group_rule` | Creates ingress and egress rules for each security group |

---

## 🔧 Input Variables

| Name | Type | Required | Default | Description |
|------|------|-----------|----------|--------------|
| `project_name` | `string` | ✅ | n/a | Project name (used for tagging and naming) |
| `environment` | `string` | ✅ | n/a | Deployment environment (`dev`, `qa`, `prod`) |
| `vpc_id` | `string` | ✅ | n/a | ID of the VPC where security groups will be created |
| `security_groups` | `map(object)` | ✅ | n/a | Map of security group definitions |
| `common_tags` | `map(string)` | ❌ | `{}` | Common tags applied to all Security Groups |



