# Route Table
resource "aws_route_table" "sp-private-rt" {
  vpc_id = var.sp-vpc-id

  route {
    cidr_block = var.sp-vpc-cidr-block
    gateway_id = "local"
  }

  tags = {
    Name        = "${var.environment}-sp-private_rt"
    Environment = var.environment
  }
}

resource "aws_route_table" "sp-public-rt" {
  vpc_id = var.sp-vpc-id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.sp-nat-id
  }

  route {
    cidr_block = var.sp-vpc-cidr-block
    gateway_id = "local"
  }

  tags = {
    Name        = "${var.environment}-sp-public-rt"
    Environment = var.environment
  }
}

resource "aws_route_table" "sp-igw-rt" {
  vpc_id = var.sp-vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.sp-igw-id
  }

  route {
    cidr_block = var.sp-vpc-cidr-block
    gateway_id = "local"
  }

  tags = {
    Name        = "${var.environment}-sp-igw-rt"
    Environment = var.environment
  }
}
