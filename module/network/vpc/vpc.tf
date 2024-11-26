resource "aws_vpc" "dev-sp-vpc" {
    count       = var.environment == "dev" ? 1 : 0
    cidr_block = var.dev-sp-vpc-cidr-block

    tags = {
        Name            = "${var.environment}-sp-vpc"
        Environment     = var.environment
        Project         = var.tags["Project"]
        Owner           = var.tags["Owner"]
    }
}

resource "aws_vpc" "prod-sp-vpc" {
    count       = var.environment == "prod" ? 1 : 0
    cidr_block  = var.prod-sp-vpc-cidr-block

    tags = {
        Name            = "${var.environment}-sp-vpc"
        Environment     = var.environment
        Project         = var.tags["Project"]
        Owner           = var.tags["Owner"]
    }
}
