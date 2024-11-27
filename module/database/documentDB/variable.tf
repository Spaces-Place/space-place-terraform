variable "sp-subnet-group-id" {
  type = string
}

variable "sp-subnet-db-active" {
  type = string
}

variable "sp-subnet-db-standby" {
  type = string
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
    cluster_identifier    = string
    engine                = string
    master_username       = string
    master_password       = string
    backup_retention_period = string
    preferred_backup_window = string
    skip_final_snapshot     = bool
  })
}
