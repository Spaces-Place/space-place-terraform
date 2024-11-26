variable "web_vpc_id" {
  type = string
}

variable "dev-sp-vpc-cidr-block" {
    description = "vpc cidr block"
    type = string
}

variable "prod-sp-vpc-cidr-block" {
    description = "vpc cidr block"
    type = string
}

variable "environment" {
    type = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
