variable "ami" {
  description = "Amazon Machine Images ID"
  default     = "ami-0f1a5f5ada0e7da53"
}

variable "local_ip" {
  default = "190.211.121.153/32"
}

variable "project_name" {
  default = "dbdevops.net-0"
}
variable "aws_profile" {
  description = "AWS credentials"
  default     = "default"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "instance_type" {
  default = "m4.xlarge"
}

variable "root_domain_name" {
  description = "root domain name"
  type        = string
  default     = "dbdevops.net"
}

variable "key_name" {
  description = "SSH Key-Pair Name"
  default     = "fchaconn"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "fchaconn.pem"
}

variable "hostname" {
  default = "fchacon_dev"
}

variable "subnet_id" {
  description = "VPC subnet id"
  default     = "subnet-08bdd38ca2c14c6a9"
}


#SG

variable "vpc_id" {
  type    = string
  default = "vpc-07313ad32c2c1fb07"
}

variable "public_hosted_zone_id" {
  type    = string
  default = "Z02514532CALQVL26P6JD"
}

variable "host_type" {
}

#Intance volumes  values
variable "intance_volumes" {
  type = object({
    OmBackup = list(object({
      name        = string
      device_name = string
      size        = number
    })),
    MongoDB = list(object({
      name        = string
      device_name = string
      size        = number
    })),
    OpsManager = list(object({
      name        = string
      device_name = string
      size        = number
    }))
  })
}
