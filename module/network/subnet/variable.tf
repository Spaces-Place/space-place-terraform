variable "web_vpc_id" {
    type = string
}

# Subnet
variable "public_a_subnet_cidr_block" {
    description = "vpc cidr block"
    type = string
    default = "172.16.0.0/24"
}

# Subnet
variable "private_a_subnet_cidr_block" {
    description = "vpc cidr block"
    type = string
    default = "172.16.8.0/24"
}

variable "az_a" {
    description = "az of private_a subnet"
    type = string
    default = "ap-northeast-2a"
}

variable "private_c_subnet_cidr_block" {
    description = "vpc cidr block"
    type = string
    default = "172.16.16.0/24"
}

variable "az_c" {
    description = "az of private_c subnet"
    type = string
    default = "ap-northeast-2c"
}
