resource "aws_docdb_cluster" "sp-docdb-cluster" {

  cluster_identifier      = var.docdb_cluster.cluster_identifier     
  engine                  = var.docdb_cluster.engine                 
  master_username         = var.docdb_cluster.master_username        
  master_password         = var.docdb_cluster.master_password        
  backup_retention_period = var.docdb_cluster.backup_retention_period
  preferred_backup_window = var.docdb_cluster.preferred_backup_window
  skip_final_snapshot     = var.docdb_cluster.skip_final_snapshot
  db_subnet_group_name    = aws_db_subnet_group.doc_subnet_group.name 
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "sp-docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.sp-docdb-cluster.id
  instance_class     = "db.t3.medium"
}

resource "aws_db_subnet_group" "doc_subnet_group" {
  subnet_ids = [var.sp-subnet-db-active, var.sp-subnet-db-standby]

  tags = {
    Name = "DB private group"
  }
}

# SSM Parameter 생성 및 RDS 엔드포인트 저장
resource "aws_ssm_parameter" "doc_endpoints" {
  name        = replace(upper("${var.docdb_cluster.cluster_identifier}"), "-", "_")
  value       = aws_docdb_cluster.sp-docdb-cluster.endpoint
  type        = "String"
  description = "Endpoint for RDS instance ${var.docdb_cluster.cluster_identifier}"
  overwrite   = true
}
