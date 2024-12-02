resource "aws_internet_gateway" "igw" {
  vpc_id = var.sp-vpc-id

  tags = {
    Name        = "${var.environment}-sp-igw"
    Environment = var.environment
  }
}
