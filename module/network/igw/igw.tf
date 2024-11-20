# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = var.web_vpc_id

  tags = {
    Name = "main"
  }
}
