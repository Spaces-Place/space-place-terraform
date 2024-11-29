# Route Table
resource "aws_route_table" "sp-private-rt" {
  vpc_id = var.vpc-id

  route {
    cidr_block = var.vpc-cidr-block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.environment}-sp-private_rt"
  }
}

resource "aws_route_table" "sp-public-rt" {
  vpc_id = var.vpc-id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat-id
  }

  route {
    cidr_block = var.vpc-cidr-block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.environment}-sp-public-rt"
  }
}

resource "aws_route_table" "sp-igw-rt" {
  vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw-id
  }

  route {
    cidr_block = var.vpc-cidr-block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.environment}-sp-igw-rt"
  }
}
