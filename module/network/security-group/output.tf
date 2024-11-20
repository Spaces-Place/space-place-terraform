output "web_sg_id" {
  value = aws_security_group.web.id
}

output "sg_for_rds_id" {
  value = aws_security_group.sg_for_rds.id
}
