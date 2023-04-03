ssh_key_pair_name     = "backup-key"
instance_profile_name = "mongo_route53"
route53_zone_name     = "db.cn-northwest-1.aws.commercetoolscn.cn"

subnets_filter = {
  name   = "tag:Name"
  values = ["*-private-*"]
}

# Projects-specific variables
vpc_id       = "vpc-02e9859db045d35e7"
project_name = "staging-projects-cn-northwest1.aws.commercetools.cn-0"

replicasets = [
  # Add new replicasets here
  {
    name = "commits-sh1",
    instances = [
      "commits-sh-0",
      "commits-sh-1",
      "commits-sh-2"
    ],
    instance_type = "t3.medium",
    disk_size     = 20
  },
  {
    name = "commits-sh2",
    instances = [
      "commits-sh-3",
      "commits-sh-4",
      "commits-sh-5"
    ],
    instance_type = "t3.medium",
    disk_size     = 20
  },
  {
    name = "commits-sh3",
    instances = [
      "commits-sh-6",
      "commits-sh-7",
      "commits-sh-8"
    ],
    instance_type = "t3.medium",
    disk_size     = 20
  }
]

replicaset_config = [
  # Add new replicasets here
  {
    name = "commits-conf",
    instances = [
      "commits-conf-0",
      "commits-conf-1",
      "commits-conf-2"
    ],
    instance_type = "t3.medium",
    disk_size     = 20
  }
]
