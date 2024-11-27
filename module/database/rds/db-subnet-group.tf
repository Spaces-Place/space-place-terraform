resource "aws_db_subnet_group" "rds_subnet_group" {
  subnet_ids = [var.sp-subnet-db-active, var.sp-subnet-db-standby]

  tags = {
    Name = "DB private group"
  }
}
