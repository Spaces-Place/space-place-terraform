variable "sp-vpc-cidr-block" {
    description = "vpc cidr block"
    type = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "environment" {
    type    = string
}
