output "sg_id" {
  description = "Security Group for nodes ID"
  value = aws_security_group.sg_nodes.id
}
output "sg_ssh_id" {
  description = "Security Group for node Admin"
  value = aws_security_group.sg_node_ssh.id
}
