locals {
  nodes_ip_formatted = formatlist("%s/32", "${module.my_ec2.ec2_instances_ip}")
}
