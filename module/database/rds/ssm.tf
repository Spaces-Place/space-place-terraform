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
  description = "database name for RDS instance ${each.value.identifier}"
  overwrite   = true
}

resource "aws_ssm_parameter" "db-username" {
  for_each = { for idx, rds in var.rds_instances : idx => rds }

  name        = "${upper(split("-", each.value.identifier)[0])}_DB_USERNAME"
  value       = each.value.username
  type        = "String"
  description = "Username for RDS instance ${each.value.identifier}"
  overwrite   = true
}

resource "aws_ssm_parameter" "db-password" {
  for_each = { for idx, rds in var.rds_instances : idx => rds }

  name        = "${upper(split("-", each.value.identifier)[0])}_DB_PASSWORD"
  value       = each.value.password
  type        = "SecureString"
  description = "Password for RDS instance ${each.value.identifier}"
  overwrite   = true
}

