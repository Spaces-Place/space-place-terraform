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

resource "aws_eks_cluster" "sp-eks" {
  name     = "${var.environment}-sp-eks"
  version  = var.eks_version
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    endpoint_private_access = var.environment == "prod" ? true : false
    endpoint_public_access  = var.environment == "dev" ? true : false

    security_group_ids = []

    subnet_ids = [
      var.sp-subnet-control-ids[0],
      var.sp-subnet-control-ids[1]
    ]
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
