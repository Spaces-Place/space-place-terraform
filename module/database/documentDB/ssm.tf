# Doc DB 정보를 SSM에 넣음
resource "aws_ssm_parameter" "doc_endpoints" {
  name        = replace(upper("${var.docdb_cluster.cluster_identifier}"), "-", "_")
  value       = aws_docdb_cluster.sp-docdb-cluster.endpoint
  type        = "String"
  description = "Endpoint for DocDB instance ${var.docdb_cluster.cluster_identifier}"
  overwrite   = true
}

resource "aws_ssm_parameter" "db-username" {
  name      = "${upper(split("-", var.docdb_cluster.cluster_identifier)[0])}_DB_USERNAME"
  value     = var.docdb_cluster.master_username
  type      = "String"
  overwrite = true
}

resource "aws_ssm_parameter" "db-password" {
  name      = "${upper(split("-", var.docdb_cluster.cluster_identifier)[0])}_DB_PASSWORD"
  value     = var.docdb_cluster.master_password
  type      = "SecureString"
  overwrite = true
}
