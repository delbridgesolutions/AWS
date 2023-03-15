#  # Projects VPC 
locals {
  az_list = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c", "${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c", "${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c" ]
}

# Calling ec2 Module
module "project-host" {

  source                 = "./ec2"
  project_name           = var.project_name
  instance_name          = var.hostname
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = module.project-security_group.sg_id //REMEMBER OUTPUT CALL
  public_hosted_zone_id =var.public_hosted_zone_id
  ebs_size               = 20
  volumes         = var.volumes
  availability_zone_names = local.az_list
}
