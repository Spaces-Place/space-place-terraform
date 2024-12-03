output "eks-additional-security-group-ids" {
  value = [aws_eks_cluster.sp-eks.vpc_config[0].cluster_security_group_id]
}
