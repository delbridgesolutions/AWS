#Call EC2 instances module
module "my_ec2" {
  source           = "./modules/instance"
  instance_sg =     module.my_security_groups.sg_id     #used to add the sg to the new  instances
  #ec2_sg_ssh       = module.my_security_groups.sg_ssh_id #used to add the sg to the new admin instance
}

#Call security groups module
module "my_security_groups" {
  source        = "./modules/sg"
  instances_ip     = formatlist("%s/32", "${module.my_ec2.instances_ip}") #Add /32 to Ips to use in cidr blocks
}
