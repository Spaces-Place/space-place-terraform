resource "aws_iam_role" "nodes" {
  name = "${var.environment}-${aws_eks_cluster.sp-eks.name}-nodes"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
POLICY
}

# This policy now includes AssumeRoleForPodIdentity for the Pod Identity Agent
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

resource "aws_eks_node_group" "sp-general" {
  cluster_name    = aws_eks_cluster.sp-eks.name
  version         = var.eks_version
  node_group_name = "sp-general"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    var.sp-subnet-data-a-id,
    var.sp-subnet-data-b-id
  ]

  instance_types = [var.node-group-sp-general-tier]

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 5
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = var.ssh-key
    source_security_group_ids = [aws_security_group.bastion-sg.id]
  }

  labels = {
    role = "sp-general"
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]

  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = {
    Name = "${var.environment}-node-group-sp-general"
  }
}

resource "aws_eks_node_group" "sp-spot" {
  cluster_name    = aws_eks_cluster.sp-eks.name
  version         = var.eks_version
  node_group_name = "sp-spot"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    var.sp-subnet-data-a-id,
    var.sp-subnet-data-b-id
  ]

  capacity_type  = "SPOT"
  instance_types = [var.node-group-sp-spot-tier]

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 15
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = var.ssh-key
    source_security_group_ids = [aws_security_group.bastion-sg.id]
  }

  labels = {
    role = "sp-spot"
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]

  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = {
    Name = "${var.environment}-node-group-sp-spot"
  }
}

resource "aws_eks_node_group" "sp-monitoring" {
  cluster_name    = aws_eks_cluster.sp-eks.name
  version         = var.eks_version
  node_group_name = "sp-monitoring"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    var.sp-subnet-data-a-id,
    var.sp-subnet-data-b-id
  ]

  capacity_type  = "SPOT"
  instance_types = [var.node-group-sp-spot-tier]

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 15
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = var.ssh-key
    source_security_group_ids = [aws_security_group.bastion-sg.id]
  }

  labels = {
    role = "sp-monitoring"
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]

  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = {
    Name = "${var.environment}-node-group-sp-monitoring"
  }
}
