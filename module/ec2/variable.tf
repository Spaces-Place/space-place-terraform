variable "ami_spring_snapshot" {
    type = string
    description = "EC2가 사용한 Machine Image"
    default = "ami-0b326ad288d7c561b"
}

variable "ami_worker_node_tier" {
    type = string
    description = "EC2가 사용할 EC2 등급"
    default = "t2.micro"
}

variable "web_sg_id" {
    type = string
}

variable "public_subnet_a_id" {
    type = string
}

variable "az_a" {
    type = string
    default = "ap-northeast-2a"
    description = "첫번째 AZ"
}

variable "availability_zone" {
    type = list(string)
    description = "EC2가 생성될 AZ"
    default = ["ap-northeast-2a", "ap-northeast-2c"]
}
