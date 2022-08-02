resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

}

resource "aws_subnet" "public" {
  availability_zone = var.az-id-1
  cidr_block = var.public_cidr
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true
}


resource "aws_subnet" "private_1" {
  vpc_id = aws_vpc.main.id

  cidr_block        = var.private_1_cidr
  availability_zone = var.az-id-1
}

resource "aws_subnet" "private_2" {
  vpc_id = aws_vpc.main.id

  cidr_block        = var.private_2_cidr
  availability_zone = var.az-id-2
}