resource "aws_vpc" "sp-vpc" {
  enable_dns_support   = true
  enable_dns_hostnames = true
  cidr_block           = var.sp-vpc-cidr-block

  tags = {
    Name        = "${var.environment}-sp-vpc"
    Environment = var.environment
  }
}

