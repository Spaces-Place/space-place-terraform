output "public_subnet_a" {
    value = aws_subnet.public_a
}

output "private_subnet_a" {
    value = aws_subnet.private_a
}

output "private_subnet_c" {
    value = aws_subnet.private_c
}

output "rds_subnet_group_id" {
    value = aws_db_subnet_group.rds_subnet_group.id
}
