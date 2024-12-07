resource "aws_security_group" "docdb-sg" {
  vpc_id = var.sp-vpc-id

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = var.eks-additional-security-group-ids
  }

  tags = {
    Name = "${var.environment}-docdb-sg"
  }
}
