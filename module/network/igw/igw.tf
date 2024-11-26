resource "aws_internet_gateway" "igw" {
  vpc_id = var.web_vpc_id

  tags = {
    Name            = "${var.environment}-sp-igw"
    Environment     = var.environment
    Project         = var.tags["Project"]
    Owner           = var.tags["Owner"]
  }
}
