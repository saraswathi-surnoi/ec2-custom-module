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

  validation {
    condition = alltrue([
      for _, inst in var.instances :
      contains(["t2.micro", "t3.micro", "t3.small", "t3.medium", "t3.large"], inst.instance_type)
    ])
    error_message = "Invalid instance type. Allowed: t2.micro, t3.micro, t3.small, t3.medium, t3.large"
  }

  default = {
    jenkins-master = {
      instance_type        = "t3.medium"
      iam_instance_profile = "IAM-ECR-Role"
      user_data            = "user_data/user_data.jenkins.sh"
      security_group_ref   = "jenkins"
      label                = "jenkins-master"
      volume_size          = 30
      volume_type          = "gp3"
    }

    java-agent = {
      instance_type        = "t3.small"
      iam_instance_profile = "IAM-ECR-Role"
      user_data            = "user_data/user_data.java.sh"
      security_group_ref   = "backend"
      label                = "java-agent"
      volume_size          = 30
      volume_type          = "gp3"
    }

    aiml-server = {
      instance_type        = "t3.large"
      user_data            = "user_data/user_data.ml.sh"
      security_group_ref   = "aiml"
      label                = "aiml-server"
      volume_size          = 30
      volume_type          = "gp3"
    }
  }
}


variable "ami_filter_name" {
  description = "AMI name filter"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "route53_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "Base domain name for Route53 records"
  type        = string
  default     = ""
}

variable "create_dns" {
  description = "Whether to create Route53 DNS records"
  type        = bool
  default     = false
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "logistics-mot"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Owner     = "DevOpsTeam"
    Project   = "Logistics-MOT"
  }
}

variable "key_pair_name" {
  description = "EC2 Key Pair Name"
  type        = string
  default     = "logistics-mot-kp"
}


variable "security_groups" {
  description = "Security group definitions"
  type = map(object({
    name        = string
    description = string
    ingress     = list(object({
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

  default = {
    jenkins = {
      name        = "logistics-mot-dev-jenkins"
      description = "Allow Jenkins UI and SSH access"
      ingress = [
        { from_port = 8080, to_port = 8080, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        # Allow SSH only from your allowed IPs
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = [local.allowed_ips]}
      ]
      egress = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    }

    backend = {
      name        = "logistics-mot-dev-backend"
      description = "Allow backend app and SSH access"
      ingress = [
        { from_port = 8080, to_port = 8080, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        # SSH from Jenkins and your IPs
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = [local.allowed_ips] },
        { from_port = 22, to_port = 22, protocol = "tcp", security_groups = ["jenkins"] }
      ]
      egress = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    }

    aiml = {
      name        = "logistics-mot-dev-aiml"
      description = "Allow AI/ML API and SSH access"
      ingress = [
        { from_port = 8000, to_port = 8000, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        # SSH from Jenkins and your IPs
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = [local.allowed_ips] },
        { from_port = 22, to_port = 22, protocol = "tcp", security_groups = ["jenkins"] }
      ]
      egress = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    }
  }
}
