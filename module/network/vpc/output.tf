output "dev-sp-vpc-id" {
    value = length(aws_vpc.dev-sp-vpc) > 0 ? aws_vpc.dev-sp-vpc[0].id : null
}

output "prod-sp-vpc-id" {
    value = length(aws_vpc.prod-sp-vpc) > 0 ? aws_vpc.prod-sp-vpc[0].id : null
}
