resource "aws_eip" "sp-eip-nat" {
  tags = {
    Name        = "${var.environment}-sp-eip"
    Environment = var.environment
    Project     = var.tags["Project"]
  }
}

# NAT Gateway
resource "aws_nat_gateway" "sp-nat" {
  allocation_id     = aws_eip.sp-eip-nat.id
  subnet_id         = var.sp-nat-subnet-id
  connectivity_type = "public" # NAT Gateway 연결 유형 (public 또는 private)

  tags = {
    Name        = "${var.environment}-sp-nat"
    Environment = var.environment
    Project     = var.tags["Project"]
  }
}

