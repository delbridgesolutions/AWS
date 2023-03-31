resource "aws_route53_record" "srv_config" {
  for_each = {
    for val in var.replicaset_config : val.name => val.instances
  }
  name    = format("_mongodb._tcp.%s.%s", each.key, var.name)
  zone_id = var.zone_id
  records = [for server in each.value : format("0 0 27017 %s.%s", server, var.route53_zone_name)]
  ttl     = "60"
  type    = "SRV"
}


resource "aws_route53_record" "srv_rs" {
  for_each = {
    for val in var.replicasets : val.name => val.instances
  }
  name    = format("_mongodb._tcp.%s.%s", each.key, var.name)
  zone_id = var.zone_id
  records = [for server in each.value : format("0 0 27017 %s.%s", server, var.route53_zone_name)]
  ttl     = "60"
  type    = "SRV"
}



