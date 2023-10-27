variable "instance_ami" {
  description = "Amazon Machine Images ID"
  default     = "ami-0f1a5f5ada0e7da53"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Quantity of EC2 instance"
  type        = number
  default     = "3"
}


variable "instance_sg" {
  description = "Security Group for instances"
  type        = string
}

variable "instance_subnet_id" {
  description = "VPC subnet id"
  default     = "subnet-08bdd38ca2c14c6a9"
}

variable "instance_name" {
    description = "tag name that we used"
    default = "delbridge"
}