# Output the public ip of the host
output "public_ip" {
 description="EC2 Instance IP"
 value =  aws_instance.ec2_instance.public_ip
}