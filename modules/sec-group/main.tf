data "aws_vpc" "default" {
  default = true
}

#Admin node Security group
resource "aws_security_group" "sg_node_ssh" {
  name        = var.sg_ssh_name
  description = var.sg_ssh_description
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = var.sg_ssh_description
    from_port   = var.sg_ssh_port
    to_port     = var.sg_ssh_port
    protocol    = var.sg_tcp_protocol
    cidr_blocks = [var.my_ip]

  }

}

# Three nodes Security group
resource "aws_security_group" "sg_nodes" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = data.aws_vpc.default.id

  #Allow admin SSH rule
  ingress {
    description = var.sg_ssh_description
    from_port   = var.sg_ssh_port
    to_port     = var.sg_ssh_port
    protocol    = var.sg_tcp_protocol
    cidr_blocks = ["${var.node_admin_ip}/32"]
  }
  egress {
    description = var.sg_ssh_description
    from_port   = var.sg_ssh_port
    to_port     = var.sg_ssh_port
    protocol    = var.sg_tcp_protocol
    cidr_blocks = ["${var.node_admin_ip}/32"]
  }

}

# Rules to allow cidr between nodes
resource "aws_security_group_rule" "allow_ips" {
  type              = "ingress"
  from_port         = var.sg_all_port
  to_port           = var.sg_all_port
  protocol          = var.sg_all_protocol
  cidr_blocks       = var.nodes_ips
  security_group_id = aws_security_group.sg_nodes.id
}
resource "aws_security_group_rule" "allow_egr_ips" {
  type              = "egress"
  from_port         = var.sg_all_port
  to_port           = var.sg_all_port
  protocol          = var.sg_all_protocol
  cidr_blocks       = var.nodes_ips
  security_group_id = aws_security_group.sg_nodes.id
}
