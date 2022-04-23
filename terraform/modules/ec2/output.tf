output "aws_instance_id" {
  value = aws_instance.default.*.id
}

output "aws_instance_public_ip" {
  value = aws_instance.default.*.public_ip
}

output "aws_instance_public_dns" {
  value = aws_instance.default.*.public_dns
}
