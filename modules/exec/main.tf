resource "terraform_data" "run_scripts" {
  # Login to the ec2-user with the aws key.
  connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = ""
    private_key = file(var.PATH_TO_PUBLIC_KEY)
    host        = var.public_ip
  }

  provisioner "file" {
    source      = var.PATH_TO_FILES
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/files/updatePacks.sh",
      "sudo /tmp/files/updatePacks.sh"
    ]
  }
  
  provisioner "remote-exec" {
    inline = var.host_type == var.hosts_types.om_backup ? [
      "chmod +x /tmp/files/ops_manager/om_backup/format.sh",
      "sudo /tmp/files/ops_manager/om_backup/format.sh"
      ] : (var.host_type == var.hosts_types.ops_manager ?
      [
        "chmod +x /tmp/files/ops_manager/om/format.sh",
        "sudo /tmp/files/ops_manager/om/format.sh"
      ]
      : [
        "chmod +x /tmp/files/mongodb/format.sh",
        "sudo /tmp/files/mongodb/format.sh"
    ])
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/files/prodnotes.sh",
      "sudo /tmp/files/prodnotes.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = var.host_type == var.hosts_types.ops_manager || var.host_type == var.hosts_types.om_backup ? [
      "chmod +x /tmp/files/ops_manager/read_a_head.sh",
      "sudo /tmp/files/ops_manager/read_a_head.sh"
      ] : (var.host_type == var.hosts_types.mongodb ?
      [
        "chmod +x /tmp/files/mongodb/read_a_head.sh",
        "sudo /tmp/files/mongodb/read_a_head.sh"
      ]
    : [])
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/files/mongo_key.sh",
      "sudo /tmp/files/mongo_key.sh"
    ]
  }
}
