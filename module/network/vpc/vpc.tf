resource "aws_vpc" "sp-vpc" {
  cidr_block           = var.sp-vpc-cidr-block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.environment}-sp-vpc"
    Environment = var.environment
  }
}

