variable "vpc_cidr_block" {
  type          = "string"
  description   = "VPC cidr block"
}

variable "public_subnet_cidr_az1" {
  type          = "string"
  description   = "public subnet cidr block in availability zone 1"
}
variable "public_subnet_cidr_az2" {
  type          = "string"
  description   = "public subnet cidr block in availability zone 2"
}
variable "public_subnet_cidr_az3" {
  type          = "string"
  description   = "public subnet cidr block in availability zone 3"
}
variable "private_subnet_cidr_az1" {
  type          = "string"
  description   = "private subnet cidr block in availability zone 1"
}
variable "private_subnet_cidr_az2" {
  type          = "string"
  description   = "public subnet cidr block in availability zone 2"
}
variable "private_subnet_cidr_az3" {
  type          = "string"
  description   = "public subnet cidr block in availability zone 3"
}
variable "tag_name" {
  type          = "string"
  description   = "name defined for the aws components inside VPC"
}
variable "tag_billing" {
  type          = "string"
  description   = "Billimg information tag for the aws components inside VPC"
}
variable "tag_developer" {
  type          = "string"
  description   = "developer information tag for the aws components inside VPC"
}
variable "tag_environment" {
  type          = "string"
  description   = "environment (pro, sta, dev, test) information"
}