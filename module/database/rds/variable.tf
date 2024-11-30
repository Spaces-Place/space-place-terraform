variable "sp-subnet-db-active" {
  type = string
}

variable "sp-subnet-db-standby" {
  type = string
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

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
