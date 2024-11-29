resource "aws_route_table_association" "sp-association-igw-a" {
  subnet_id      = var.subnet-ids["public"]
  route_table_id = aws_route_table.sp-igw-rt.id
}

resource "aws_route_table_association" "sp-association-control-a" {
  subnet_id      = var.subnet-ids["control-a"]
  route_table_id = aws_route_table.sp-public-rt.id
}

resource "aws_route_table_association" "sp-association-control-b" {
  subnet_id      = var.subnet-ids["control-b"]
  route_table_id = aws_route_table.sp-public-rt.id
}

resource "aws_route_table_association" "sp-association-data-a" {
  subnet_id      = var.subnet-ids["data-a"]
  route_table_id = aws_route_table.sp-public-rt.id
}

resource "aws_route_table_association" "sp-association-data-b" {
  subnet_id      = var.subnet-ids["data-b"]
  route_table_id = aws_route_table.sp-public-rt.id
}

resource "aws_route_table_association" "sp-association-db-active" {
  subnet_id      = var.subnet-ids["db-active"]
  route_table_id = var.environment == "dev" ? aws_route_table.sp-igw-rt.id : aws_route_table.sp-private-rt.id
}

resource "aws_route_table_association" "sp-association-db-standby" {
  subnet_id      = var.subnet-ids["db-standby"]
  route_table_id = var.environment == "dev" ? aws_route_table.sp-igw-rt.id : aws_route_table.sp-private-rt.id
}

resource "aws_route_table_association" "sp-association-nat" {
  subnet_id      = var.nat-id
  route_table_id = aws_route_table.sp-igw-rt.id
}
