variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "worker_instance_type" {
  description = "EC2 instance type based on environment"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "dev-sp-vpc-cidr-block" {
    description = "vpc cidr block"
    type = string
}

variable "prod-sp-vpc-cidr-block" {
    description = "vpc cidr block"
    type = string
}
