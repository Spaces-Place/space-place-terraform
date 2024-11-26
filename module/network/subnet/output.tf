output "subnet_ids" {
  value = {
    control_a   = aws_subnet.sp-subnet-control-a.id
    control_b   = aws_subnet.sp-subnet-control-b.id
    data_a      = aws_subnet.sp-subnet-data-a.id
    data_b      = aws_subnet.sp-subnet-data-b.id
    db_active   = aws_subnet.sp-subnet-db-active.id
    db_standby  = aws_subnet.sp-subnet-db-standby.id
    nat         = aws_subnet.sp-subnet-nat.id
  }
  description = "IDs of the created subnets"
}
