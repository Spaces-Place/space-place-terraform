output "web-sg-id" {
  value = aws_security_group.web-sg.id
}

output "rds-sg-name" {
  value = aws_security_group.rds-sg.name
}

output "document-sg-id" {
  value = aws_security_group.document-sg.id
}
