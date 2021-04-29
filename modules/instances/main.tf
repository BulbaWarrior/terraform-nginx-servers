resource "aws_instance" "app_server" {
  ami                         = var.instance_ami
  key_name                    = var.instance_key_name
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_groups
  associate_public_ip_address = true
  count                       = var.instance_count
  tags                        = var.tags

  # use remote-exec to ensure the instances are in running state before creating dependent resources
  provisioner "remote-exec" {
    inline = ["sudo apt install -y python3"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_key_private)
      host        = self.public_ip
    }
  }

}

resource "null_resource" "aggregate_instances" {
  triggers = {
    instance_ips = join(", ", aws_instance.app_server[*].public_ip)
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${join(", ", aws_instance.app_server[*].public_ip)}' --private-key ${var.ssh_key_private} ${var.playbook_path}"
  }
}
