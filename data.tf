data "aws_security_group" "custom" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Project"
    values = [var.project_name]
  }
}

data "aws_iam_instance_profile" "ec2_instance_profile" {
  name = var.instance_profile_name
}

data "aws_key_pair" "ssh_key_pair" {
  key_name = var.ssh_key_pair_name
}

data "aws_route53_zone" "private" {
  name         = var.route53_zone_name
  private_zone = true
}
