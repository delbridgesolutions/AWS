output "ec2_instance_ip" {
  description = "The private IP address Assigned to the principal intance"
  value       = try("${aws_instance.ec2_instance.private_ip}", "")
}
output "ec2_instances_ip" {
  description = "List of private IP addresses Assigned to the intances"
  value       = try("${aws_instance.ec2_instances.*.private_ip}", "")
}
