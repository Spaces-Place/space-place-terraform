resource "aws_docdb_cluster" "sp-docdb-cluster" {
  cluster_identifier      = var.docdb_cluster.cluster_identifier
  engine                  = var.docdb_cluster.engine
  master_username         = var.docdb_cluster.master_username
  master_password         = var.docdb_cluster.master_password
  backup_retention_period = var.docdb_cluster.backup_retention_period
  preferred_backup_window = var.docdb_cluster.preferred_backup_window
  skip_final_snapshot     = var.docdb_cluster.skip_final_snapshot
  db_subnet_group_name    = aws_db_subnet_group.doc_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.docdb-sg.id]

  tags = {
    Name = "${var.environment}-docdb-cluster"
  }
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "sp-docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.sp-docdb-cluster.id
  instance_class     = "db.t3.medium"

  tags = {
    Name = "${var.environment}-cluster-instances"
  }
}

resource "aws_db_subnet_group" "doc_subnet_group" {
  subnet_ids = var.docdb-associate-subnet-ids

  tags = {
    Name = "${var.environment}-doc-subnet-group"
  }
}


