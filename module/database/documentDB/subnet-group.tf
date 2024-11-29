resource "aws_db_subnet_group" "doc_subnet_group" {
  subnet_ids = var.db-subnet-group-ids

  tags = {
    Name = "${var.environment}-sp-doc-subnet-group"
  }
}
