#Ec2 Instances Security Group
resource "aws_security_group" "this" {
  vpc_id      = var.vpc_id
  name        = "${var.project_name}-sg"
  description = var.sg_description
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "${var.project_name}-sg" }

}
resource "aws_security_group_rule" "sg-rule-15" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = [var.local_ip]
}

