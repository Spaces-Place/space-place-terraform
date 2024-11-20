resource "aws_security_group" "sg_for_rds" {
  name = "sg_for_rds"
  vpc_id = var.web_vpc_id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.web.id]
  }
}
