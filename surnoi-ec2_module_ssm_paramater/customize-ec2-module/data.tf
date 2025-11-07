# -------------------------
# Data Sources
# -------------------------

# ✅ Fetch VPC ID from SSM Parameter Store
data "aws_ssm_parameter" "vpc_id" {
  name = "/logistics-mot/dev/vpc_id"
}

# ✅ Fetch Public Subnet ID (or Subnet List) from SSM Parameter Store
# If this parameter holds a single subnet ID as plain text, this will work.
data "aws_ssm_parameter" "public_subnets" {
  name = "/logistics-mot/dev/public_subnets"
}

# ✅ Fetch your custom AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["361769585646"] # Your custom AMI owner account ID

  filter {
    name   = "name"
    values = ["logistics-mot-ubuntu-base-v1.0.0"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



