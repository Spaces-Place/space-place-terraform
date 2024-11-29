variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "vpc-id" {
  type = string
}

variable "nat-id" {
  type = string
}

variable "igw-id" {
  type = string
}

variable "vpc-cidr-block" {
  type = string
}

variable "subnet-ids" {
  type = map(string)
}
