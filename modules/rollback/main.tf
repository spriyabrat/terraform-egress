##############
# For hs-us-east-1-prod-nat-routes 
##############
resource "aws_route" "private_route_hs_us_east_1_prod_vpc_nat" {
  route_table_id            = var.prod_nat_rt
  destination_cidr_block    = var.default_route
  nat_gateway_id = var.prod_nat1
}

resource "aws_route" "private_route_hs_us_east_1_prod_vpc1_nat" {
  route_table_id            = var.prod_nat_rt_1
  destination_cidr_block    = var.default_route
  nat_gateway_id = var.prod_nat2
}

################
# For Data VPC nat route
################
resource "aws_route" "private_route_data_vpc_nat" {
  route_table_id            = var.data_rt
  destination_cidr_block    = var.default_route
  nat_gateway_id = var.data_nat
}

###############
# For hs-us-east-1 VPC nat route
###############
resource "aws_route" "private_route_hs_us_east_1_vpc_nat" {
  route_table_id            = var.hs_us_east_1_rt
  destination_cidr_block    = var.default_route
  nat_gateway_id = var.hs_us_east_1_nat
}
