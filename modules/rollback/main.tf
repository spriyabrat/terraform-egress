##############
# For hs-us-east-1-prod-nat-routes 
##############
resource "aws_route" "private-route-hs-us-east-1-prod-vpc-nat" {
  route_table_id            = "rtb-073959b2bb4f95547"
  destination_cidr_block    = var.default_route
  nat_gateway_id = var.prod_nat1
}

resource "aws_route" "private-route-hs-us-east-1-prod-vpc1-nat" {
  route_table_id            = "rtb-035c6e50940a85d85"
  destination_cidr_block    = var.default_route
  nat_gateway_id = var.prod_nat2
}

################
# For Data VPC nat route
################
resource "aws_route" "private-route-data-vpc-nat" {
  route_table_id            = "rtb-04aa153b2d09019f4"
  destination_cidr_block    = var.default_route
  nat_gateway_id = var.data_nat
}

###############
# For hs-us-east-1 VPC nat route
###############
resource "aws_route" "private-route-hs-us-east-1-vpc-nat" {
  route_table_id            = "rtb-0c60804bd32ed1b2a"
  destination_cidr_block    = var.default_route
  nat_gateway_id = var.hs_us_east_1_nat
}
