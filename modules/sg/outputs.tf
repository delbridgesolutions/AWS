
output "sg_id" {
  description = "Security Group for node Admin"
  value = aws_security_group.this.id
}
