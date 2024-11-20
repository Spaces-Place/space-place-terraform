resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 0
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [var.web_vpc_cidr_block]
  security_group_id = aws_security_group.web.id
}
