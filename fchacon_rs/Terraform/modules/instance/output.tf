output "instances_ip" {
  description = "List of private IP addresses Assigned to the intances"
  value       = try("${aws_instance.instance.*.private_ip}", "")
}
