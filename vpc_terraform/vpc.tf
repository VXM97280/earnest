provider "aws" {
  region      = "${var.region}"
}

# VPC 
resource "aws_vpc" "earnest_vpc" {
  cidr_block       = "${var.vpc_cidr_block}"
  instance_tenancy = "default"

  tags {
    Name        = "${var.tag_environment}-${var.tag_name}-vpc"
    Billing     = "${var.tag_billing}"
    Developer   = "${var.tag_developer}"
  }
}

# public subnets
resource "aws_subnet" "public_az1" {
  vpc_id            = "${aws_vpc.earnest_vpc.id}"
  cidr_block        = "${var.public_subnet_cidr_az1}"
  availability_zone = "us-east-1a"

  tags {
    Name        = "${var.tag_environment}-${var.tag_name}-public-us-east-1a"
    Developer   = "${var.tag_developer}"
  }
}

resource "aws_subnet" "public_az2" {
  vpc_id            = "${aws_vpc.earnest_vpc.id}"
  cidr_block        = "${var.public_subnet_cidr_az2}"
  availability_zone = "us-east-1b"

  tags {
    Name        = "${var.tag_environment}-${var.tag_name}-public-us-east-1b"
    Developer   = "${var.tag_developer}"
  }
}

resource "aws_subnet" "public_az3" {
  vpc_id            = "${aws_vpc.earnest_vpc.id}"
  cidr_block        = "${var.public_subnet_cidr_az3}"
  availability_zone = "us-east-1c"

  tags {
    Name        = "${var.tag_environment}-${var.tag_name}-public-us-east-1c"
    Developer   = "${var.tag_developer}"
  }
}

# private subnets
resource "aws_subnet" "private_az1" {
  vpc_id            = "${aws_vpc.earnest_vpc.id}"
  cidr_block        = "${var.private_subnet_cidr_az1}"
  availability_zone = "us-east-1a"

  tags {
    Name        = "${var.tag_environment}-${var.tag_name}-private-us-east-1a"
    Developer   = "${var.tag_developer}"
  }
}

resource "aws_subnet" "private_az2" {
  vpc_id            = "${aws_vpc.earnest_vpc.id}"
  cidr_block        = "${var.private_subnet_cidr_az2}"
  availability_zone = "us-east-1b"

  tags {
    Name        = "${var.tag_environment}-${var.tag_name}-private-us-east-1b"
    Developer   = "${var.tag_developer}"
  }
}

resource "aws_subnet" "private_az3" {
  vpc_id            = "${aws_vpc.earnest_vpc.id}"
  cidr_block        = "${var.private_subnet_cidr_az3}"
  availability_zone = "us-east-1c"

  tags {
    Name        = "${var.tag_environment}-${var.tag_name}-private-us-east-1c"
    Developer   = "${var.tag_developer}"
  }
}

# internet gateway
resource "aws_internet_gateway" "vpc_gw" {
  vpc_id = "${aws_vpc.earnest_vpc.id}"

  tags {
    Name        = "${var.tag_environment}-${var.tag_name}-IGW"
  }
}

# elastic IP (Required for NAT gateway)
# resource "aws_eip" "bar" {
#   vpc = true

#   instance                  = "${aws_instance.foo.id}"
#   associate_with_private_ip = "10.0.0.12"
#   depends_on                = ["aws_internet_gateway.gw"]
# }

