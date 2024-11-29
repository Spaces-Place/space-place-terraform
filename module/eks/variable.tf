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

variable "worker-instance-type" {
  type = string
}

variable "eks_version" {
  default = "1.31"
  type    = string
}

variable "sp-subnet-control-ids" {
  type = list(string)
}

variable "sp-subnet-data-ids" {
  type = list(string)
}
