output "aws_key_pair_private" {
  value = tls_private_key.ssh_key_gen.private_key_pem
}

output "aws_key_pair_public" {
  value = tls_private_key.ssh_key_gen.public_key_openssh
}
