variable "rds_instance_az" {
  type = string
  default = "ap-northeast-2a"
}

variable "private_subnet_a_id" {
  type = string
}

variable "private_subnet_c_id" {
  type = string
}

variable "allocated_storage" {
  type        = number 
  description = "The amount of allocated storage for the database (in GB)"
  default = 10
}

variable "db_name" {
  type        = string
  description = "The name of the database"
  default = "farmHaNiDB"
}

variable "engine" {
  type        = string
  description = "The database engine to be used (e.g., mysql, postgres)"
  default = "mysql"
}

variable "engine_version" {
  type        = string
  description = "The version of the database engine"
  default = "8.0"
}

variable "instance_class" {
  type        = string
  description = "The instance class (e.g., db.t2.micro)"
  default = "db.t3.micro"
}

variable "username" {
  type        = string
  description = "The master username for the database"
  default = "root"
  sensitive = true
}

variable "password" {
  type        = string
  description = "DB 비밀번호인데 일단은 간단하게 설정해놓고 나중에 Parameter Store나 Secret Manager로 관리할 예정"
  default = "123401234"
  sensitive   = true
}

variable "parameter_group_name" {
  type        = string
  description = "The name of the parameter group to use"
  default = "default.mysql8.0"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Whether to skip the final snapshot when the DB is deleted"
  default = true
}

variable "rds_subnet_group_id" {
  type = string
}

variable "db_security_group_name" {
  type = string
}
