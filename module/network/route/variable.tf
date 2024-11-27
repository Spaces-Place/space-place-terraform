variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "sp-vpc-id" {
  type = string
}

variable "sp-nat-id" {
  type = string
}

variable "sp-vpc-cidr-block" {
  type = string
}

variable "sp-subnet-control-a-id" {
  type = string
}

variable "sp-subnet-control-b-id" {
  type = string
}

variable "sp-subnet-data-a-id" {
  type = string
}

variable "sp-subnet-data-b-id" {
  type = string
}

variable "sp-subnet-db-active-id" {
  type = string
}

variable "sp-subnet-db-standby-id" {
  type = string
}

variable "sp-subnet-nat-id" {
  type = string
}

variable "sp-subnet-public-id" {
  type = string
}

variable "sp-igw-id" {
  type = string
}
