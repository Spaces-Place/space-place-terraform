resource "aws_iam_role" "eks" {
  name = "${var.environment}-role-eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

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
  instance_type               = "t2.micro"
  availability_zone           = "ap-northeast-2a"
  security_groups             = [aws_security_group.bastion-sg.id]
  subnet_id                   = var.sp-subnet-public-id
  associate_public_ip_address = true

  tags = {
    Name = "backend"
  }
}



resource "aws_eks_cluster" "sp-eks" {
  name     = "${var.environment}-sp-eks"
  version  = var.eks_version
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    endpoint_private_access = var.environment == "prod" ? true : false
    endpoint_public_access  = var.environment == "dev" ? true : false

    subnet_ids = [
      var.sp-subnet-control-a-id,
      var.sp-subnet-control-b-id
    ]
    security_group_ids = [aws_security_group.eks_control_plane_sg.id]
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [aws_iam_role_policy_attachment.eks]
  tags = {
    Name        = "${var.environment}-sp-eks"
    Environment = var.environment
    Project     = var.tags["Project"]
    Owner       = var.tags["Owner"]
  }
}
