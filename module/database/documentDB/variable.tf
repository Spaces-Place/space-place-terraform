variable "sp-vpc-id" {
  type = string
}

variable "eks-additional-security-group-ids" {
  type = list(string)
}

variable "docdb-associate-subnet-ids" {
  type = list(string)
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "docdb_cluster" {
  type = object({
    cluster_identifier      = string
    engine                  = string
    master_username         = string
    master_password         = string
    backup_retention_period = string
    preferred_backup_window = string
    skip_final_snapshot     = bool
  })
}
