variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "db-subnet-group-ids" {
  type = list(string)
}

variable "vpc-security-group-ids" {
  type = list(string)
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

variable "docdb_instance" {
  type = object({
    count          = number
    instance_class = string
  })
}
