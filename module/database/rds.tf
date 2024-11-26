resource "aws_db_instance" "rds" {
  for_each = { for idx, rds in var.rds_instances : idx => rds }

  identifier          = each.value.identifier
  engine              = each.value.engine
  instance_class      = each.value.instance_class
  allocated_storage   = each.value.allocated_storage
  username            = each.value.username
  password            = each.value.password
  db_name             = each.value.db_name
  multi_az            = each.value.multi_az

  parameter_group_name = lookup(each.value, "parameter_group", null)
  db_subnet_group_name = lookup(each.value, "subnet_group", null)

  # Add other configurations if needed
  publicly_accessible = false
}

