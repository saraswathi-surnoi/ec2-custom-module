variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_pair_name" {
  type = string
}

variable "instances" {
  description = "Map of EC2 instance configurations"
  type = map(object({
    instance_type        = string
    iam_instance_profile = optional(string)
    user_data            = optional(string)
    security_group_ref   = string
    label                = optional(string)
    volume_size          = optional(number, 20)
    volume_type          = optional(string, "gp3")
  }))
}

variable "sg_map" {
  description = "Map of security group references from SG module"
  type        = map(string)
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}


variable "create_dns" {
  description = "Whether to create Route53 DNS records"
  type        = bool
  default     = false
}
variable "route53_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "Base domain name for DNS records"
  type        = string
  default     = ""
}
