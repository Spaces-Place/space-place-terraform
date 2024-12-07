data "aws_ami" "python_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["docker-python-user-backend"]
  }
}

data "aws_key_pair" "default_key_pair" {
  key_name           = "default_key_pair"
  include_public_key = true
}

# Network Interface
resource "aws_instance" "backend" {
  ami                         = data.aws_ami.python_ami.id
  key_name                    = data.aws_key_pair.default_key_pair.key_name
  instance_type               = "t3.micro"
  availability_zone           = "ap-northeast-2a"
  security_groups             = [aws_security_group.bastion-sg.id]
  subnet_id                   = var.sp-subnet-public-id
  associate_public_ip_address = true

  tags = {
    Name = "${var.environment}-bastion"
  }
}
