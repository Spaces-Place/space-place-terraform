resource "aws_vpc" "sp-vpc" {
    cidr_block = var.sp-vpc-cidr-block

    tags = {
        Name            = "${var.environment}-sp-vpc"
        Environment     = var.environment
        Project         = var.tags["Project"]
        Owner           = var.tags["Owner"]
    }
}

