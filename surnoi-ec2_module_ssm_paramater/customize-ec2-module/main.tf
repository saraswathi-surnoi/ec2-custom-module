module "security_groups" {
  source          = "./sg-module"
  project_name    = var.project_name
  environment     = var.environment
  security_groups = var.security_groups
  vpc_id          = data.aws_vpc.default.id
  common_tags     = var.common_tags
}

module "ec2_instances" {
  source          = "./ec2-module"
  project_name    = var.project_name
  environment     = var.environment
  ami_id          = data.aws_ami.ubuntu.id
  subnet_id       = tolist(data.aws_subnet_ids.default.ids)[0]
  key_pair_name   = var.key_pair_name
  instances       = var.instances
  sg_map          = module.security_groups.sg_map
  common_tags     = var.common_tags
  route53_zone_id = var.route53_zone_id
  domain_name     = var.domain_name
  create_dns      = var.create_dns
}
