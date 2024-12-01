variable "ssh-key" {
  type = string
}

variable "sp-vpc-id" {
  type = string
}

variable "sp-sg-cluster" {
  type = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "environment" {
  type = string
}

variable "worker_instance_type" {
  type = string
}

variable "eks_version" {
  default = "1.31"
  type    = string
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

variable "sp-subnet-public-id" {
  type = string
}
