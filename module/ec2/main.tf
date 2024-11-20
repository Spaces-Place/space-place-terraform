data "aws_ami" "python_ami" {
    most_recent = true
    filter {
        name = "name"
        values = ["docker-python-user-backend"]
    }
}

data "aws_key_pair" "default_key_pair" {
  key_name           = "default_key_pair"
  include_public_key = true
}

# Network Interface
resource "aws_instance" "backend" {
    ami = data.aws_ami.python_ami.id
    key_name = data.aws_key_pair.default_key_pair.key_name
    instance_type = var.ami_worker_node_tier
    availability_zone = var.az_a
    security_groups = [var.web_sg_id]
    subnet_id = var.public_subnet_a_id
    associate_public_ip_address = true
    tags = {
        Name = "backend"
    }
}
