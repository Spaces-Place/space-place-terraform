resource "aws_db_subnet_group" "sp-subnet-group-rds" {
  name = "${var.environment}-sp-subnet-group-rds"

  subnet_ids = [aws_subnet.sp-subnet-db-active.id, aws_subnet.sp-subnet-db-standby.id] #if multi AZ add another subnet
}
