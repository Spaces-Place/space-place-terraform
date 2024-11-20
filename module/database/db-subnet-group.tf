resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "main"
  subnet_ids = [var.private_subnet_a_id, var.private_subnet_c_id]

  tags = {
    Name = "DB private group"
  }
}
