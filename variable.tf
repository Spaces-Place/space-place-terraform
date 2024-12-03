variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "worker_instance_type" {
  description = "EC2 instance type based on environment"
  type        = string
}

variable "node-group-sp-general-tier" {
  type = string
}

variable "node-group-sp-spot-tier" {
  type = string
}

variable "node-group-sp-monitoring-tier" {
  type = string
}

variable "sp-vpc-cidr-block" {
  description = "vpc cidr block"
  type        = string
  default     = null
}

variable "rds_instances" {
  description = "List of RDS instances to create"
  type = list(object({
    identifier        = string
    engine            = string
    instance_class    = string
    allocated_storage = number
    username          = string
    password          = string
    db_name           = string
    parameter_group   = optional(string)
    subnet_group      = optional(string)
    multi_az          = optional(bool, false)
  }))
}

variable "docdb_cluster" {
  type = object({
    cluster_identifier      = string
    engine                  = string
    master_username         = string
    master_password         = string
    backup_retention_period = string
    preferred_backup_window = string
    skip_final_snapshot = bool }
  )
}
