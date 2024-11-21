resource "aws_vpc" "space-place-vpc-eks" {
	cidr_block							= "10.0.0.0/16"
	
	enable_dns_support			= true
	enable_dns_hostnames		= true

	tags = {
		Name = "space-place-vpc-eks-${local.env}"
		env	 = "${local.env}"
	}
}
