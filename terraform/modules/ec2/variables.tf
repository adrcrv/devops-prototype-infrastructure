variable "aws_key_pair_private" {
  type = string
}

variable "aws_key_pair_name" {
  type = string
}

variable "aws_key_pair_dir" {
  type = string
}

variable "aws_instance_count" {
  type = number
}

variable "aws_instance_ami" {
  type = string
}

variable "aws_instance_ami_user" {
  type = string
}

variable "aws_instance_type" {
  type = string
}

variable "aws_instance_tags" {
  type = map(string)
}
