variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_id" {
  description = "VPC ID where the security groups will be created"
  type        = string
}


variable "allowed_ips" {
  description = "List of CIDR blocks allowed for SSH access"
  type        = list(string)
}


variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "security_groups" {
  description = "Map of security group configurations"
  type = map(object({
    name        = string
    description = string
    ingress = list(object({
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = optional(list(string))
      security_groups  = optional(list(string))
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}

