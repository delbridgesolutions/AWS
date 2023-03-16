variable "ami" {
}

variable "instance_type" {

}

variable "key_name" {
}

variable "subnet_id" {
}

variable "project_name" {
}

variable "intance_volumes" {
}


variable "instance_name" {
}

variable "vpc_security_group_ids" {
}

variable "public_hosted_zone_id" {
}

variable "ebs_size" {
}

variable "availability_zone_names" {
}
variable "host_type" {
  type = string
  description = "Type of ec2 instance"
  validation {
    condition = contains(["MongoDB", "OpsManager", "OpsBackup"], var.host_type)
    error_message = "Valid value is one of the following: MongoDB, OpsManager,OpsManager1."
  }
}


