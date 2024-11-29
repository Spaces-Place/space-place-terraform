locals {
  az_a = "ap-northeast-2a"
  az_b = "ap-northeast-2c"
}

resource "aws_subnet" "sp-subnet-public" {
  vpc_id            = var.web_vpc_id
  cidr_block        = var.environment == "dev" ? "10.0.1.0/24" : "10.1.1.0/24"
  availability_zone = local.az_a

  tags = {
    Name = "${var.environment}-sp-subnet-public-a"
  }
}

# Subnet
resource "aws_subnet" "sp-subnet-control-a" {
  vpc_id            = var.web_vpc_id
  cidr_block        = var.environment == "dev" ? "10.0.0.0/24" : "10.1.0.0/24"
  availability_zone = local.az_a

  tags = {
    Name = "${var.environment}-sp-subnet-control-a"
  }
}

resource "aws_subnet" "sp-subnet-control-b" {
  vpc_id     = var.web_vpc_id
  cidr_block = var.environment == "dev" ? "10.0.5.0/24" : "10.1.5.0/24"

  availability_zone = local.az_b

  tags = {
    Name = "${var.environment}-sp-subnet-control-b"
  }
}

resource "aws_subnet" "sp-subnet-data-a" {
  vpc_id            = var.web_vpc_id
  cidr_block        = var.environment == "dev" ? "10.0.10.0/24" : "10.1.10.0/24"
  availability_zone = local.az_a

  tags = {
    Name                              = "${var.environment}-sp-subnet-data-a"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "sp-subnet-data-b" {
  vpc_id            = var.web_vpc_id
  cidr_block        = var.environment == "dev" ? "10.0.20.0/24" : "10.1.20.0/24"
  availability_zone = local.az_b

  tags = {
    Name                              = "${var.environment}-sp-subnet-data-b"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "sp-subnet-db-active" {
  vpc_id            = var.web_vpc_id
  cidr_block        = var.environment == "dev" ? "10.0.30.0/24" : "10.1.30.0/24"
  availability_zone = local.az_a

  tags = {
    Name = "${var.environment}-sp-subnet-db-active"
  }
}

resource "aws_subnet" "sp-subnet-db-standby" {
  vpc_id            = var.web_vpc_id
  cidr_block        = var.environment == "dev" ? "10.0.32.0/24" : "10.1.32.0/24"
  availability_zone = local.az_b

  tags = {
    Name = "${var.environment}-sp-subnet-db-standby"
  }
}

resource "aws_subnet" "sp-subnet-nat" {
  vpc_id            = var.web_vpc_id
  cidr_block        = var.environment == "dev" ? "10.0.34.0/24" : "10.1.34.0/24"
  availability_zone = local.az_b

  tags = {
    Name = "${var.environment}-sp-subnet-nat"
  }
}
