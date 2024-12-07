resource "aws_db_instance" "sp-rds" {
  for_each = { for idx, rds in var.rds_instances : idx => rds }

  identifier           = each.value.identifier
  engine               = each.value.engine
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  instance_class       = each.value.instance_class
  allocated_storage    = each.value.allocated_storage
  username             = each.value.username
  password             = each.value.password
  db_name              = each.value.db_name
  multi_az             = each.value.multi_az
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds-sg.id] 

  parameter_group_name = lookup(each.value, "parameter_group", null)

  # Add other configurations if needed
  publicly_accessible = var.environment == "dev" ? true : false

  tags = {
    Name        = "${var.environment}-sp-rds"
    Environment = var.environment
    Project     = var.tags["Project"]
    Owner       = var.tags["Owner"]
  }
}
