#Call EC2 instances module
module "my_ec2" {
  source           = "./modules/ec2"
  ec2_sg_instances = module.my_security_groups.sg_id     #used to add the sg to the new  instances
  ec2_sg_ssh       = module.my_security_groups.sg_ssh_id #used to add the sg to the new admin instance
}

#Call security groups module
module "my_security_groups" {
  source        = "./modules/sec-group"
  node_admin_ip = module.my_ec2.ec2_instance_ip
  nodes_ips     = local.nodes_ip_formatted #Add /32 to Ips to use in cidr blocks
}
