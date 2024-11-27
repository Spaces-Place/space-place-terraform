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

# SSM Parameter 생성 및 RDS 엔드포인트 저장
resource "aws_ssm_parameter" "rds_endpoints" {
  for_each = aws_db_instance.sp-rds

  name        = replace(upper("${each.value.identifier}"), "-", "_")
  value       = each.value.endpoint
  type        = "String"
  description = "Endpoint for RDS instance ${each.value.identifier}"
  overwrite   = true
}

resource "aws_ssm_parameter" "db-name" {
  for_each = { for idx, rds in var.rds_instances : idx => rds }

  name        = "${upper(split("-", each.value.identifier)[0])}_DB_NAME"
  value       = each.value.db_name
  type        = "String"
  description = "Endpoint for RDS instance ${each.value.identifier}"
  overwrite   = true
}

resource "aws_ssm_parameter" "db-username" {
  for_each = { for idx, rds in var.rds_instances : idx => rds }

  name        = "${upper(split("-", each.value.identifier)[0])}_DB_USERNAME"
  value       = each.value.username
  type        = "String"
  description = "Endpoint for RDS instance ${each.value.identifier}"
  overwrite   = true
}

resource "aws_ssm_parameter" "db-password" {
  for_each = { for idx, rds in var.rds_instances : idx => rds }

  name        = "${upper(split("-", each.value.identifier)[0])}_DB_PASSWORD"
  value       = each.value.password
  type        = "SecureString"
  description = "Endpoint for RDS instance ${each.value.identifier}"
  overwrite   = true
}
