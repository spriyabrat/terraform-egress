output "firewall_subnet_id" {
  value = aws_subnet.firewall_subnet.id
}

output "ngw_vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "ngw_vpc_attachment_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.ngw-vpc.id
}
