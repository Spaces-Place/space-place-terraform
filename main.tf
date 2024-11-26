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
  sp-vpc-cidr-block = var.environment == "dev" ? var.dev-sp-vpc-cidr-block : var.prod-sp-vpc-cidr-block
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
  sp-vpc-cidr-block       = module.vpc.sp-vpc-cidr-block
  sp-subnet-control-a-id  = module.subnet.subnet_ids["control-a"]
  sp-subnet-control-b-id  = module.subnet.subnet_ids["control-b"]
  sp-subnet-data-a-id     = module.subnet.subnet_ids["data-a"]
  sp-subnet-data-b-id     = module.subnet.subnet_ids["data-b"]
  sp-subnet-db-active-id  = module.subnet.subnet_ids["db-active"]
  sp-subnet-db-standby-id = module.subnet.subnet_ids["db-standby"]
  sp-subnet-nat-id        = module.subnet.subnet_ids["nat"]
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

module "database" {
  source                 = "./module/database"
  sp-subnet-db-active    = module.subnet.subnet_ids["db-active"]
  sp-subnet-db-standby   = module.subnet.subnet_ids["db-standby"]
  db-security-group-name = module.security-group.rds-sg-name
  sp-subnet-group-id     = module.subnet.sp-subnet-group-rds.id
  rds_instances          = var.rds_instances
}
