resource "aws_db_subnet_group" "rds_subnet_group" {
  subnet_ids = var.associate-subnet-ids

  tags = {
    Name = "DB private group"
  }
}
