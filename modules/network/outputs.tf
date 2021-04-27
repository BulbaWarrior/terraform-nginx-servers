output "vpc_subnet" {
  description = "Created vpc subnet"
  value       = aws_subnet.main
}

output "security_group" {
  description = "security group associated with the vpc"
  value       = aws_security_group.all_tcp_v4
}
