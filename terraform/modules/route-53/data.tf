data "aws_route53_zone" "default" {
  name = var.aws_route53_host
}
