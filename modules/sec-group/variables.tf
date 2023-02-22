
variable "my_ip" {
  description = "Your Ip public"
  default     = "190.211.121.153/32"
}

variable "node_admin_ip" {
  description = "fhcacon-dev ip"
  type        = string
}
variable "nodes_ips" {
  description = "fchacon-devs ips"
  type        = list(any)

}


/*
Security group Nodes
*/
variable "sg_name" {
  default = "sg_nodes"
}
variable "sg_description" {
  default = "Allow conection betwween nodes"
}

variable "sg_ing_description" {
  default = "Security Group allow inbound only their ips"
}

variable "sg_egrs_description" {
  default = "Security Group allow outbound only their ips"
}

#Variables for all ports and protocols

variable "sg_all_port" {
  description = "Allow access to all ports"
  type    = number
  default = "0"
}

variable "sg_all_protocol" {
  description = "Allow access to all protocols"
  default = "-1"
}


variable "sg_tcp_protocol" {
  description = "TCP protocol"
  default = "tcp"
}


#Variables SSH

variable "sg_ssh_name" {
  description = "Name of ssh security group"
  default = "sg_node_ssh"
}

variable "sg_ssh_description" {
  description = "Description of ssh security group"
  default = "Allow SSH connection"
}
variable "sg_ssh_port" {
  description = "SSH port number"
  type    = number
  default = "22"
}
