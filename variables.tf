variable "aws_region" {
  default = "cn-northwest-1"
}

variable "ami" {
  default = "ami-04e5e7fc2d306e6de"
}

variable "ssh_key_pair_name" {
  type    = string
  default = ""
}

variable "route53_zone_name" {
  type    = string
  default = ""
}

variable "instance_profile_name" {
  type    = string
  default = ""
}

variable "project_name" {
  type    = string
  default = ""
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "additional_tags" {
  type    = map(any)
  default = {}
}

variable "replicasets" {
  type = list(object({
    name          = string
    instances     = list(string)
    instance_type = string
    disk_size     = number
  }))
  default = []
}

variable "replicaset_config" {
  type = list(object({
    name          = string
    instances     = list(string)
    instance_type = string
    disk_size     = number
  }))
  default = []
}

variable "sharded_clusters" {
  type = list(object({
    name = string
    configset = object({
      name          = string
      instances     = list(string)
      instance_type = string
      disk_size     = number
    })
    shards = list(object({
      name          = string
      instances     = list(string)
      instance_type = string
      disk_size     = number
    }))
  }))
  default = []
}

variable "subnets_filter" {
  type = object({
    name   = string
    values = list(string)
  })
  default = {
    name   = ""
    values = []
  }
}