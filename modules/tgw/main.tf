#######
# Resource block to create Transit Gateway
#######
resource "aws_ec2_transit_gateway" "tgw" {
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  description = "Transit Gateway for Egress"
  tags = {
    Name = "tgw"
  }
}
