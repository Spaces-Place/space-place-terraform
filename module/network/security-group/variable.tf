variable "sp-vpc-id" {
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

variable "sp-vpc-cidr-block" {
  type = string
}
