data "aws_eks_cluster" "sp-eks" {
  name = aws_eks_cluster.sp-eks.name
}


data "aws_eks_cluster_auth" "sp-eks" {
  name = aws_eks_cluster.sp-eks.name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.sp-eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.sp-eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.sp-eks.token
  }
}
