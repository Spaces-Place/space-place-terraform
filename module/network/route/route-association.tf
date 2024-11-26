resource "aws_route_table_association" "sp-association-control-a" {
  subnet_id      = var.sp-subnet-control-a-id
  route_table_id = aws_route_table.sp-private-rt.id
}

resource "aws_route_table_association" "sp-association-control-b" {
  subnet_id      = var.sp-subnet-control-b-id
  route_table_id = aws_route_table.sp-private-rt.id
}

resource "aws_route_table_association" "sp-association-data-a" {
  subnet_id      = var.sp-subnet-data-a-id
  route_table_id = aws_route_table.sp-private-rt.id
}

resource "aws_route_table_association" "sp-association-data-b" {
  subnet_id      = var.sp-subnet-data-b-id 
  route_table_id = aws_route_table.sp-private-rt.id
}

resource "aws_route_table_association" "sp-association-db-active" {
  subnet_id      = var.sp-subnet-db-active-id 
  route_table_id = aws_route_table.sp-private-rt.id
}

resource "aws_route_table_association" "sp-association-db-standby" {
  subnet_id      = var.sp-subnet-db-standby-id 
  route_table_id = aws_route_table.sp-private-rt.id
}

resource "aws_route_table_association" "sp-association-nat" {
  subnet_id      = var.sp-subnet-nat-id 
  route_table_id = aws_route_table.sp-public-rt.id
}
