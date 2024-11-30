resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 0
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [var.sp-vpc-cidr-block]
  security_group_id = aws_security_group.web-sg.id
}
