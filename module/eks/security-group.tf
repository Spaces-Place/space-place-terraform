resource "aws_security_group" "bastion-sg" {
  vpc_id = var.sp-vpc-id

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#resource "aws_security_group" "additional-security-group" {
#  name        = "${var.environment}-eks-data-plane-sg"
#  description = "Security group for EKS Node Group"
#  vpc_id      = var.sp-vpc-id
#
#  ingress {
#    from_port = 22
#    to_port = 22
#    protocol = "tcp"
#    security_groups = [aws_security_group.bastion-sg.id]
#  }
#
#  ingress {
#    from_port   = 443
#    to_port     = 443
#    protocol    = "tcp"
#    security_groups = [aws_security_group.eks_control_plane_sg.id]
#  }
#
#  ingress {
#    from_port   = 10250
#    to_port     = 10250
#    protocol    = "tcp"
#    cidr_blocks = ["10.0.0.0/16"] # VPC CIDR for internal Kubernetes traffic
#  }
#
#  ingress {
#    from_port   = 30000
#    to_port     = 32767
#    protocol    = "tcp"
#    cidr_blocks = ["10.0.0.0/16"]
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  tags = {
#    Name        = "${var.environment}-eks-data-plane-sg"
#    Environment = var.environment
#  }
#}

resource "aws_security_group" "eks_control_plane_sg" {
  name        = "${var.environment}-eks-control-plane-sg"
  description = "Security group for EKS Control Plane"
  vpc_id      = var.sp-vpc-id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.bastion-sg.id]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # or restrict to trusted IP ranges
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-eks-control-plane-sg"
    Environment = var.environment
  }
}

