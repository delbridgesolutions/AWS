variable "PATH_TO_PUBLIC_KEY" {

}

variable "PATH_TO_FILES" {
}

variable "public_ip" {
}

variable "host_type" {

}

variable "hosts_types" {
  type = object ({
    ops_manager = string
    om_backup = string
    mongodb = string
  })
  default = {
    ops_manager = "OpsManager",
    om_backup   = "OmBackup",
    mongodb     = "MongoDB"
  }
}
