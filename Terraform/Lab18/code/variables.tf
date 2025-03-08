variable "region" {
  type        = string
  description = "AWS Region"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "subnet_cidr_blocks" {
  type        = list(string)
  description = "List of subnet CIDR blocks"
}

variable "subnet_az" {
  type        = list(string)
  description = "List of availability zones for subnets"
}

variable "subnet_name" {
  type        = list(string)
  description = "List of subnet names"
}

variable "instance_ami" {
  type        = string
  description = "AMI ID for instances"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}
