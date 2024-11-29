variable "sp-vpc-id" {
  type = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "sp-vpc-cidr-block" {
  type = string
}
