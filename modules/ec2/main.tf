data "aws_subnet" "current_subnet" {
  id = var.subnet_id
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  subnet_id       = var.subnet_id
  security_groups = ["${var.vpc_security_group_ids}"]
  key_name        = var.key_name

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
  }

  tags = { Name = var.instance_name, Project = var.project_name, Type = var.host_type }
}

#Route 53 Records
resource "aws_route53_record" "www" {
  zone_id = var.public_hosted_zone_id
  name    = var.instance_name
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2_instance.private_ip, aws_instance.ec2_instance.public_ip]
}


# VOLUMES attachments
resource "aws_ebs_volume" "ebs_volumes" {
  for_each          = { for v in var.intance_volumes[var.host_type] : v.name => v }
  availability_zone = data.aws_subnet.current_subnet.availability_zone
  size              = each.value.size
  type              = "gp3"
  encrypted         = true
  tags              = { Name = "${var.instance_name}-ebs-volume-${each.value.name}", }

}

resource "aws_volume_attachment" "volume_attachments" {
  for_each = { for v in var.intance_volumes[var.host_type] : v.name => v }

  device_name                    = each.value.device_name
  instance_id                    = aws_instance.ec2_instance.id
  volume_id                      = aws_ebs_volume.ebs_volumes[each.key].id
  stop_instance_before_detaching = true
}


