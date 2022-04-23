terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    github = {
      source  = "integrations/github"
      version = "4.23.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "github" {
  token = var.github_token
}

module "aws_key_pair" {
  source            = "../../modules/key-pair"
  aws_key_pair_name = var.aws_key_pair_name
  aws_key_pair_dir  = var.aws_key_pair_dir
  aws_key_pair_tags = var.aws_tags
}

module "aws_security_group" {
  source   = "../../modules/security-group"
  for_each = var.aws_security_group_ports
  port     = each.value
}

module "aws_ec2" {
  depends_on            = [module.aws_key_pair, module.aws_security_group]
  source                = "../../modules/ec2"
  aws_instance_count    = var.aws_instance_count
  aws_instance_ami      = var.aws_instance_ami
  aws_instance_ami_user = var.aws_instance_ami_user
  aws_instance_type     = var.aws_instance_type
  aws_instance_tags     = var.aws_tags
  aws_key_pair_name     = var.aws_key_pair_name
  aws_key_pair_dir      = var.aws_key_pair_dir
  aws_key_pair_private  = module.aws_key_pair.aws_key_pair_private
}

module "github" {
  depends_on               = [module.aws_key_pair, module.aws_ec2]
  source                   = "../../modules/github"
  for_each                 = var.github_repository
  github_repository        = each.value
  github_private_key_title = var.github_private_key_title
  github_private_key_value = module.aws_key_pair.aws_key_pair_private
  github_hosts_key         = var.github_hosts_key
  github_hosts_value       = module.aws_ec2.aws_instance_public_dns
  github_hosts_user_key    = var.github_hosts_user_key
  github_hosts_user_value  = var.aws_instance_ami_user
}

module "route_53" {
  depends_on          = [module.aws_ec2]
  source              = "../../modules/route-53"
  aws_route53_host    = var.aws_route53_host
  aws_route53_name    = var.aws_route53_name
  aws_route53_records = module.aws_ec2.aws_instance_public_ip
}
