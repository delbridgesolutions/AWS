
#Resource to build three Ec2 instances (nodes)
resource "aws_instance" "ec2_instances" {
  ami             = var.ec2_ami
  count           = var.ec2_count
  instance_type   = var.ec2_instance_type
  security_groups = ["${var.ec2_sg_instances}"]
  subnet_id       = var.ec2_subnet_id
  tags = {
    "Name" = "${var.ec2_tags}-${count.index + 1}"
  }
}

#Resource to build one Ec2 instance (Admin)
resource "aws_instance" "ec2_instance" {
  ami             = var.ec2_ami
  instance_type   = var.ec2_instance_type
  security_groups = ["${var.ec2_sg_ssh}"]
  subnet_id       = var.ec2_subnet_id
  key_name        = var.ssh_key_name
  tags = {
    "Name" = "${var.ec2_tags}"
  }
}
