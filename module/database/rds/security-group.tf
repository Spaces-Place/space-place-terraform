resource "aws_security_group" "rds-sg" {
  vpc_id = var.sp-vpc-id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = var.eks-additional-security-group-ids
  }

  tags = {
    Name = "${var.environment}-rds-sg"
  }
}
