variable "vpc_id" {
  description = "VPC ID to create security group and rules in"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = ""
}

variable "local_ip" {
  description = "Local network ip"
  type = string
  default = ""
}

variable "sg_description" {
  default = "security group that allows necessary traffic to the instance"
}

variable "ingress_rules_with_self" {
    description = "Mapping List of ingress rules inside the VPC"
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
  default = []
}

variable "ingress_rules_with_cird_blocks" {
    description = "Mapping list of ingress rules with CIDR blocks"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}