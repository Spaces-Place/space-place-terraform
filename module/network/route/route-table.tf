# Route Table
resource "aws_route_table" "public_route_table" {
    vpc_id = var.web_vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.igw_id 
    }

    route {
        cidr_block = var.web_vpc_cidr_block 
        gateway_id = "local"
    }

    tags = {
        Name = "public_route_table"
    }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = var.web_vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.igw_id 
    }

    route {
        cidr_block = var.web_vpc_cidr_block 
        gateway_id = "local"
    }

    tags = {
        Name = "public_route_table"
    }
}
