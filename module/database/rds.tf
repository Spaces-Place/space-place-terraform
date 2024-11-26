resource "aws_db_instance" "rds" {
  for_each = { for idx, rds in var.rds_instances : idx => rds }

  identifier            = each.value.identifier
  engine                = each.value.engine
  db_subnet_group_name  = aws_db_subnet_group.rds_subnet_group.name 
  instance_class        = each.value.instance_class
  allocated_storage     = each.value.allocated_storage
  username              = each.value.username
  password              = each.value.password
  db_name               = each.value.db_name
  multi_az              = each.value.multi_az
  skip_final_snapshot   = true

  parameter_group_name = lookup(each.value, "parameter_group", null)

  # Add other configurations if needed
  publicly_accessible = false
}

# SSM Parameter 생성 및 RDS 엔드포인트 저장
resource "aws_ssm_parameter" "rds_endpoints" {
  for_each = aws_db_instance.rds

  name        = replace(upper("${each.value.identifier}"), "-", "_")
  value       = each.value.endpoint
  type        = "String"
  description = "Endpoint for RDS instance ${each.value.identifier}"
}
