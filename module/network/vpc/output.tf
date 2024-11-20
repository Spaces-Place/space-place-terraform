output "web_vpc_id" {
    value = aws_vpc.web.id
}

output "web_vpc_cidr_block" {
    value = aws_vpc.web.cidr_block
}
