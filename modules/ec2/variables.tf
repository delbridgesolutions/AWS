
variable "ec2_ami" {
  description = "Amazon Machine Images ID"
  default     = "ami-0f1a5f5ada0e7da53"
}
variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
variable "ec2_count" {
  description = "Quantity of EC2 instance"
  type        = number
  default     = "3"
}
variable "ec2_sg_instances" {
  description = "Security Group for instances"
  type        = string
}
variable "ec2_sg_ssh" {
  description = "Security Group for instances with ssh"
  type        = string
}
variable "ec2_subnet_id" {
  description = "VPC subnet id"
  default     = "subnet-08bdd38ca2c14c6a9"
}
variable "ec2_tags" {
  description = "Tag to use in EC2"
  default     = "fchacon-dev"
}

variable "ssh_key_name" {
  description = "SSH Key-Pair Name"
  default     = "fchaconn"
}
