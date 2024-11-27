output "subnet_ids" {
  value = {
    control-a  = aws_subnet.sp-subnet-control-a.id
    control-b  = aws_subnet.sp-subnet-control-b.id
    data-a     = aws_subnet.sp-subnet-data-a.id
    data-b     = aws_subnet.sp-subnet-data-b.id
    db-active  = aws_subnet.sp-subnet-db-active.id
    db-standby = aws_subnet.sp-subnet-db-standby.id
    nat        = aws_subnet.sp-subnet-nat.id
    public     = aws_subnet.sp-subnet-public.id
  }
  description = "IDs of the created subnets"
}

output "sp-subnet-group-rds" {
  value = aws_db_subnet_group.sp-subnet-group-rds
}
