variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}


variable "public_subnet_a_id" {
  type = string
}

variable "private_subnet_a_id" {
  type = string
}

variable "private_subnet_c_id" {
  type = string
}

variable "web_vpc_id" {
  type = string
}

variable "igw_id" {
  type = string
}

variable "web_vpc_cidr_block" {
  type = string
}
