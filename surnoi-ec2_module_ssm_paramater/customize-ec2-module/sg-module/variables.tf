variable "project_name" { type = string }
variable "environment" { type = string }
variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}
variable "vpc_id" { type = string }
variable "common_tags" { type = map(string) }

