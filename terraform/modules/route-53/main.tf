terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_route53_record" "blank" {
  zone_id = data.aws_route53_zone.default.zone_id
  name    = var.aws_route53_name
  type    = "A"
  ttl     = "300"
  records = var.aws_route53_records
}
