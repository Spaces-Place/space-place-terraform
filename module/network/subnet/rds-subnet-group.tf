resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_c.id ]  #if multi AZ add another subnet
}
