output "vpc_id" {
  value = aws_vpc.demo.id
}

output "vpc_cidr" {
  value = aws_vpc.demo.cidr_block
}