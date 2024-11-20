resource "aws_vpc" "web" {
    cidr_block = var.web_vpc_cidr_block

    tags = {
        Name = "vpc"
    }
}
