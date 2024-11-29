provider "aws" {
  region = "ap-northeast-2"

  default_tags {
    tags = {
      environment = var.environment
      Owner       = "space-place"
    }
  }
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.75"
    }
  }
}

module "vpc" {
  source            = "./module/network/vpc"
  environment       = var.environment
  sp-vpc-cidr-block = var.vpc-cidr-block
}

module "igw" {
  source      = "./module/network/igw"
  environment = var.environment
  sp-vpc-id   = module.vpc.sp-vpc-id
}

module "route" {
  source         = "./module/network/route"
  environment    = var.environment
  vpc-id         = module.vpc.sp-vpc-id
  nat-id         = module.nat.sp-nat-id
  igw-id         = module.igw.igw_id
  vpc-cidr-block = module.vpc.sp-vpc-cidr-block
  subnet-ids     = module.subnet.subnet_ids
}

module "nat" {
  source           = "./module/nat"
  environment      = var.environment
  sp-nat-subnet-id = module.subnet.subnet_ids.nat
}

module "security-group" {
  source            = "./module/network/security-group"
  environment       = var.environment
  sp-vpc-id         = module.vpc.sp-vpc-id
  sp-vpc-cidr-block = module.vpc.sp-vpc-cidr-block
}

module "subnet" {
  source      = "./module/network/subnet"
  web_vpc_id  = module.vpc.sp-vpc-id
  environment = var.environment
}

module "rds" {
  source               = "./module/database/rds"
  environment          = var.environment
  associate-subnet-ids = [module.subnet.subnet_ids["data-a"], module.subnet.subnet_ids["data-b"]]
  security-group-ids   = module.security-group.rds-security-group-ids
  rds_instances        = var.rds_instances
}

module "documentDB" {
  source                 = "./module/database/documentDB"
  environment            = var.environment
  db-subnet-group-ids    = [module.subnet.subnet_ids["data-a"], module.subnet.subnet_ids["data-b"]]
  vpc-security-group-ids = module.security-group.sp-docdb-security-group-ids
  docdb_cluster          = var.docdb_cluster
  docdb_instance         = var.docdb_instance
}

module "eks" {
  source                = "./module/eks"
  sp-vpc-id             = module.vpc.sp-vpc-id
  worker-instance-type  = var.worker_instance_type
  sp-sg-cluster         = module.security-group.sp-security-group-for-cluster-id
  environment           = var.environment
  sp-subnet-control-ids = [module.subnet.subnet_ids["control-a"], module.subnet.subnet_ids["control-b"]]
  sp-subnet-data-ids    = [module.subnet.subnet_ids["data-a"], module.subnet.subnet_ids["data-b"]]
}

module "ec2" {
  source              = "./module/ec2"
  sp-subnet-public-id = module.subnet.subnet_ids["public"]
  web_sg_id           = module.security-group.web-sg-id
}
