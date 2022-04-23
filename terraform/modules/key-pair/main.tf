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
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}

resource "tls_private_key" "ssh_key_gen" {
  algorithm = "RSA"
}

resource "local_file" "ssh_private_key_save" {
  depends_on      = [tls_private_key.ssh_key_gen]
  filename        = pathexpand("${var.aws_key_pair_dir}/${var.aws_key_pair_name}")
  content         = tls_private_key.ssh_key_gen.private_key_pem
  file_permission = "400"
}

resource "local_file" "ssh_public_key_save" {
  depends_on = [tls_private_key.ssh_key_gen]
  filename   = pathexpand("${var.aws_key_pair_dir}/${var.aws_key_pair_name}.pub")
  content    = tls_private_key.ssh_key_gen.public_key_openssh
}

resource "aws_key_pair" "key_pair" {
  depends_on = [tls_private_key.ssh_key_gen]
  key_name   = var.aws_key_pair_name
  public_key = tls_private_key.ssh_key_gen.public_key_openssh
  tags       = var.aws_key_pair_tags
}
