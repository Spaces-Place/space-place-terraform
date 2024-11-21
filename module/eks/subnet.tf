resource "aws_subnet" "private_zone1" {
	vpc_id					= aws_vpc.space-place-vpc-eks.id
	cidr_block				= "10.0.0.0/24"
	availability_zone	= local.zone1

	tags = {
		"Name"																									= "space-place-${local.env}-private-${local.zone1}"
		"kubernetes.io/role/internal-elb"												= "1"
		"kubernetes.io/cluster/${local.env}-${local.eks_name}"	= "owned"
		"env"																										= local.env
	}
}

resource "aws_subnet" "private_zone2" {
	vpc_id						= aws_vpc.space-place-vpc-eks.id
	cidr_block				= "10.0.10.0/24"
	availability_zone	= local.zone2

	tags = {
		"Name"																									= "space-place-${local.env}-private-${local.zone2}"
		"kubernetes.io/role/internal-elb"												= "1"
		"kubernetes.io/cluster/${local.env}-${local.eks_name}"	= "owned"
		"env"																										= local.env
	}
}

resource "aws_subnet" "public_zone1" {
	vpc_id					= aws_vpc.space-place-vpc-eks.id
	cidr_block							= "10.0.200.0/24"
	availability_zone				= local.zone1
	map_public_ip_on_launch = true 

	tags = {
		"Name"																									= "space-place-${local.env}-public-${local.zone1}"
		"kubernetes.io/role/internal-elb"												= "1"
		"kubernetes.io/cluster/${local.env}-${local.eks_name}"	= "owned"
		"env"																										= local.env
	}
}

resource "aws_subnet" "public_zone2" {
	vpc_id					= aws_vpc.space-place-vpc-eks.id
	cidr_block							= "10.0.210.0/24"
	availability_zone				= local.zone2
	map_public_ip_on_launch = true 

	tags = {
		"Name"																									= "space-place-${local.env}-public-${local.zone2}"
		"kubernetes.io/role/internal-elb"												= "1"
		"kubernetes.io/cluster/${local.env}-${local.eks_name}"	= "owned"
		"env"																										= local.env
	}
}
