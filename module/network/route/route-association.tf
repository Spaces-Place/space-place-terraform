resource "aws_route_table_association" "public_a_association" {
  subnet_id      = var.public_subnet_a_id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_a_association" {
  subnet_id      = var.private_subnet_a_id 
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_c_association" {
  subnet_id      = var.private_subnet_c_id
  route_table_id = aws_route_table.private_route_table.id
}
