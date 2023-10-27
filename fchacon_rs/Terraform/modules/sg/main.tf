data "aws_vpc" "default" {
  default = true
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
    cidr_blocks = ["${var.my_ip}/32"]
  }
  egress {
    description = var.sg_ssh_description
    from_port   = var.sg_ssh_port
    to_port     = var.sg_ssh_port
    protocol    = var.sg_tcp_protocol
    cidr_blocks = ["${var.my_ip}/32"]
  }

}

# Rules to allow cidr between nodes
resource "aws_security_group_rule" "allow_ips" {
  type              = "ingress"
  from_port         = var.sg_all_port
  to_port           = var.sg_all_port
  protocol          = var.sg_tcp_protocol
  cidr_blocks       = var.instances_ip
  security_group_id = aws_security_group.sg_nodes.id
}
resource "aws_security_group_rule" "allow_egr_ips" {
  type              = "egress"
  from_port         = var.sg_all_port
  to_port           = var.sg_all_port
  protocol          = var.sg_tcp_protocol
  cidr_blocks       = var.instances_ip
  security_group_id = aws_security_group.sg_nodes.id
}


resource "aws_security_group_rule" "allow_internet" {
  description = "Allow Internet outbound"
  type              = "egress"
  from_port         = var.fist_port
  to_port           = var.last_port
  protocol          = var.all_protocols
  cidr_blocks       = [var.public_access]
  security_group_id = aws_security_group.sg_nodes.id
}
