
data "aws_ssm_parameter" "vpc_id" {
  name = "/logistics-mot/dev/vpc_id"
}


data "aws_ssm_parameter" "public_subnets" {
  name = "/logistics-mot/dev/public_subnets"
}


data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["361769585646"] 

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



