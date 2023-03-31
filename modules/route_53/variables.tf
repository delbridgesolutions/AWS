variable "name" {

}

variable "zone_id" {

}

variable "route53_zone_name" {

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
