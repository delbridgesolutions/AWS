
#Print ip admin after apply in console
output "ip_Admin" {
  description = "This is the ip of the Admin host"
  value       = module.my_ec2.ec2_instance_ip
}


#Print array with ips after apply in console
output "ip_Hosts" {
  description = "This is array with ips of the nodes"
  value       = module.my_ec2.ec2_instances_ip
}
