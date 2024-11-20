# Subnet
resource "aws_subnet" "public_a" {
    vpc_id = var.web_vpc_id
    cidr_block = var.public_a_subnet_cidr_block 
    availability_zone = var.az_a 

    tags = {
        Name = "public_a"
    }
}

resource "aws_subnet" "private_a" {
    vpc_id = var.web_vpc_id
    cidr_block = var.private_a_subnet_cidr_block 
    availability_zone = var.az_a

    tags = {
        Name = "private_a"
    }
}

resource "aws_subnet" "private_c" {
    vpc_id = var.web_vpc_id
    cidr_block = var.private_c_subnet_cidr_block
    availability_zone = var.az_c 

    tags = {
        Name = "private_c"
    }
}
