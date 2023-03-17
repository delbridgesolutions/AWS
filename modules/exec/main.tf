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
    source      = "${var.PATH_TO_FILES}/updatePacks.sh"
    destination = "/tmp/updatePacks.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/updatePacks.sh",
      "sudo /tmp/updatePacks.sh"
    ]
  }
}
