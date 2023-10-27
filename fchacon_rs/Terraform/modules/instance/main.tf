#Resource to build three Ec2 instances (nodes)
locals {
  instance_name= "delbridge"
}

resource "aws_instance" "instance" {
  key_name = "fchaconn"
  ami             = var.instance_ami
  count           = var.instance_count
  instance_type   = var.instance_type
  security_groups = ["${var.instance_sg}"]
  subnet_id       = var.instance_subnet_id
  tags = {
    "Name" = "${local.instance_name}-${count.index + 1}"
  }
}