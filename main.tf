provider "aws" {
  region = "ap-northeast-2"
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
  sp-vpc-cidr-block = var.sp-vpc-cidr-block
  tags              = var.tags
  environment       = var.environment
}

module "igw" {
  source      = "./module/network/igw"
  sp-vpc-id   = module.vpc.sp-vpc-id
  environment = var.environment
  tags        = var.tags
}

module "route" {
  source                  = "./module/network/route"
  environment             = var.environment
  tags                    = var.tags
  sp-vpc-id               = module.vpc.sp-vpc-id
  sp-nat-id               = module.nat.sp-nat-id
  sp-igw-id               = module.igw.igw_id
  sp-vpc-cidr-block       = module.vpc.sp-vpc-cidr-block
  sp-subnet-control-a-id  = module.subnet.subnet_ids["control-a"]
  sp-subnet-control-b-id  = module.subnet.subnet_ids["control-b"]
  sp-subnet-data-a-id     = module.subnet.subnet_ids["data-a"]
  sp-subnet-data-b-id     = module.subnet.subnet_ids["data-b"]
  sp-subnet-db-active-id  = module.subnet.subnet_ids["db-active"]
  sp-subnet-db-standby-id = module.subnet.subnet_ids["db-standby"]
  sp-subnet-nat-id        = module.subnet.subnet_ids["nat"]
  sp-subnet-public-id     = module.subnet.subnet_ids["public"]
}

module "nat" {
  source           = "./module/nat"
  environment      = var.environment
  tags             = var.tags
  sp-nat-subnet-id = module.subnet.subnet_ids.nat
}

module "security-group" {
  source            = "./module/network/security-group"
  sp-vpc-id         = module.vpc.sp-vpc-id
  tags              = var.tags
  sp-vpc-cidr-block = module.vpc.sp-vpc-cidr-block
  environment       = var.environment
}

module "subnet" {
  source      = "./module/network/subnet"
  web_vpc_id  = module.vpc.sp-vpc-id
  environment = var.environment
  tags        = var.tags
}

module "rds" {
  source               = "./module/database/rds"
  environment          = var.environment
  tags                 = var.tags
  sp-subnet-db-active  = module.subnet.subnet_ids["db-active"]
  sp-subnet-db-standby = module.subnet.subnet_ids["db-standby"]
  rds_instances        = var.rds_instances
}

module "documentDB" {
  sp-vpc-id   = module.vpc.sp-vpc-id
  source               = "./module/database/documentDB"
  environment          = var.environment
  tags                 = var.tags
  eks-additional-security-group-ids = module.eks.eks-additional-security-group-ids
  docdb-associate-subnet-ids = [module.subnet.subnet_ids["data-a"], module.subnet.subnet_ids["data-b"]]
  docdb_cluster        = var.docdb_cluster
}

module "eks" {
  source                 = "./module/eks"
  sp-vpc-id         = module.vpc.sp-vpc-id
  worker_instance_type   = var.worker_instance_type
  sp-sg-cluster          = module.security-group.cluster-sg-id
  ssh-key = "default_key_pair" 
  environment            = var.environment
  sp-subnet-control-a-id = module.subnet.subnet_ids["control-a"]
  sp-subnet-control-b-id = module.subnet.subnet_ids["control-b"]
  sp-subnet-data-a-id    = module.subnet.subnet_ids["data-a"]
  sp-subnet-data-b-id    = module.subnet.subnet_ids["data-b"]
  sp-subnet-public-id    = module.subnet.subnet_ids["public"]
  node-group-sp-general-tier = var.node-group-sp-general-tier
  node-group-sp-spot-tier = var.node-group-sp-spot-tier
  node-group-sp-monitoring-tier = var.node-group-sp-monitoring-tier 
  tags                   = var.tags
}
