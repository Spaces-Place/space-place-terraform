provider "aws" {
    region = "ap-northeast-2"
}

module "vpc" {
    source = "./module/network/vpc"
}

module "igw" {
    source = "./module/network/igw"
    web_vpc_id = module.vpc.web_vpc_id
}

module "route" {
    source = "./module/network/route"
    web_vpc_id = module.vpc.web_vpc_id
    igw_id = module.igw.igw_id
    web_vpc_cidr_block = module.vpc.web_vpc_cidr_block
    public_subnet_a_id = module.subnet.public_subnet_a.id
    private_subnet_a_id = module.subnet.private_subnet_a.id
    private_subnet_c_id = module.subnet.private_subnet_c.id 
}

module "security-group" {
    source = "./module/network/security-group"
    web_vpc_id = module.vpc.web_vpc_id
    web_vpc_cidr_block = module.vpc.web_vpc_cidr_block
    private_subnet_a_id = module.subnet.private_subnet_a.id
    private_subnet_c_id = module.subnet.private_subnet_c.id 
}

module "database" {
    source = "./module/database"
    private_subnet_a_id = module.subnet.private_subnet_a.id
    private_subnet_c_id = module.subnet.private_subnet_c.id
    db_security_group_name = module.security-group.sg_for_rds_id
    rds_subnet_group_id = module.subnet.rds_subnet_group_id
}

module "subnet" {
    source = "./module/network/subnet"
    web_vpc_id = module.vpc.web_vpc_id
}

module "ec2" {
    source = "./module/ec2"
    web_sg_id = module.security-group.web_sg_id
    public_subnet_a_id = module.subnet.public_subnet_a.id
    availability_zone = ["ap-northeast-2a", "ap-northeast-2c"]
}
