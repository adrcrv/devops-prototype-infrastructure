variable "aws_profile" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "aws_key_pair_name" {
  type    = string
  default = "devops-tcc"
}

variable "aws_key_pair_dir" {
  type    = string
  default = "~/.ssh"
}

variable "aws_security_group_ports" {
  type = set(string)
}

variable "aws_instance_ami" {
  type    = string
  default = "ami-001089eb624938d9f"
}

variable "aws_instance_ami_user" {
  type    = string
  default = "ec2-user"
}

variable "aws_instance_count" {
  type    = number
  default = 1
}

variable "aws_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "aws_route53_host" {
  type    = string
  default = "devops-tcc.com.br"
}

variable "aws_route53_name" {
  type    = string
  default = ""
}

variable "aws_tags" {
  type = map(string)
  default = {
    Name = "devops-tcc"
  }
}

variable "github_token" {
  type = string
}

variable "github_repository" {
  type = set(string)
}

variable "github_private_key_title" {
  type    = string
  default = "SSH_PRIVATE_KEY"
}

variable "github_hosts_key" {
  type    = string
  default = "INSTANCE_HOSTS"
}

variable "github_hosts_user_key" {
  type    = string
  default = "INSTANCE_USER"
}