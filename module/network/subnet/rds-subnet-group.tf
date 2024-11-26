resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.sp-subnet-db-active.id, aws_subnet.sp-subnet-db-standby.id ]  #if multi AZ add another subnet
}
