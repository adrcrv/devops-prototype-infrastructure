terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

resource "aws_instance" "default" {
  count         = var.aws_instance_count
  ami           = var.aws_instance_ami
  instance_type = var.aws_instance_type
  key_name      = data.aws_key_pair.default.key_name
  tags          = var.aws_instance_tags

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.aws_instance_ami_user
      host        = self.public_dns
      private_key = var.aws_key_pair_private
    }

    inline = ["echo 'Remote connection successfully established'"]
  }
}

resource "local_file" "ansible_inventory" {
  depends_on = [aws_instance.default]
  filename   = "${local.ansible_path}/misc/hosts"
  content = templatefile("${path.module}/template.tfpl", {
    ip_addresses = aws_instance.default.*.public_dns
    user         = var.aws_instance_ami_user
    private_key  = var.aws_key_pair_private
  })
}

resource "null_resource" "ansible_playbook" {
  depends_on = [local_file.ansible_inventory, aws_instance.default]

  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook ${local.ansible_path}/playbooks/setup.yaml \
      --inventory ${local.ansible_path}/misc/hosts \
      --private-key ${var.aws_key_pair_dir}/${var.aws_key_pair_name}
    EOT
  }
}
