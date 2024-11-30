output "web-sg-id" {
  value = aws_security_group.web-sg.id
}

output "rds-sg-name" {
  value = aws_security_group.rds-sg.name
}

output "rds-sg-id" {
  value = aws_security_group.rds-sg.id
}

output "document-sg-id" {
  value = aws_security_group.document-sg.id
}

output "cluster-sg-id" {
  value = aws_security_group.cluster-sg.id
}
