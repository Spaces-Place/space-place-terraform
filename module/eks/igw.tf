resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.space-place-vpc-eks.id

	tags = {
		Name = "space-place-igw-${local.env}"
		env	 = "${local.env}"
	}
}
