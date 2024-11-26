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

variable "dev-sp-vpc-cidr-block" {
  description = "vpc cidr block"
  type        = string
  default     = null
}

variable "prod-sp-vpc-cidr-block" {
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
