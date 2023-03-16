module "project-security_group" {
  source       = "./sg-module"
  project_name = var.project_name
  vpc_id       = var.vpc_id
  local_ip     = var.local_ip

}
