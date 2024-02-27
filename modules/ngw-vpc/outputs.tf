output "firewall-subnet-id" {
  value = aws_subnet.firewall_subnet.id
}

output "ngw-vpc-id" {
  value = aws_vpc.my_vpc.id
}

output "ngw-vpc-attachment-id" {
  value = aws_ec2_transit_gateway_vpc_attachment.ngw-vpc.id
}
