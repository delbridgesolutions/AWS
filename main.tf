module "rs_config_servers" {
  for_each               = { for val in var.replicaset_config : val.name => val }
  source                 = "../../modules/cluster"
  project_name           = var.project_name
  private_hosted_zone_id = data.aws_route53_zone.private.zone_id

  ami                    = var.ami
  vpc_id                 = var.vpc_id
  cluster                = each.value
  key_name               = data.aws_key_pair.ssh_key_pair.key_name
  ec2_instance_profile   = data.aws_iam_instance_profile.ec2_instance_profile
  vpc_security_group_ids = [data.aws_security_group.custom.id]
  additional_tags        = { deployment = each.key }
  subnets_filter         = var.subnets_filter
}

module "rs_sh" {
  for_each               = { for val in var.replicasets : val.name => val }
  source                 = "../../modules/cluster"
  project_name           = var.project_name
  private_hosted_zone_id = data.aws_route53_zone.private.zone_id

  ami                    = var.ami
  vpc_id                 = var.vpc_id
  cluster                = each.value
  key_name               = data.aws_key_pair.ssh_key_pair.key_name
  ec2_instance_profile   = data.aws_iam_instance_profile.ec2_instance_profile
  vpc_security_group_ids = [data.aws_security_group.custom.id]
  additional_tags        = { deployment = each.key }
  subnets_filter         = var.subnets_filter
}


module "www_record" {
  source  = "./modules/route_53"
  name    = data.aws_route53_zone.private.name
  zone_id = data.aws_route53_zone.private.zone_id
  route53_zone_name = var.route53_zone_name
}
