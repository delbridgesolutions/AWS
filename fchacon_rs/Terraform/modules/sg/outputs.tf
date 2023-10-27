output "sg_id" {
  description = "Security Group for nodes ID"
  value = aws_security_group.sg_nodes.id
}
