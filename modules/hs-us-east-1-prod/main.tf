#######################################################################
## For HS-US-EAST-1-PROD
## This tf script creates tgw entry in private route table and 
## vpc attachments for tgw
## and transit gateway route table, its assocation and its routes
########################################################################

resource "aws_route" "private-route-hs-us-east-1-prod-vpc" {
  route_table_id            = "rtb-073959b2bb4f95547"
  destination_cidr_block    = var.default_route
  transit_gateway_id = var.tgw_id
}

resource "aws_route" "private-route-hs-us-east-1-prod-vpc1" {
  route_table_id            = "rtb-035c6e50940a85d85"
  destination_cidr_block    = var.default_route
  transit_gateway_id = var.tgw_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "hs_us_east_1_prod" {
  subnet_ids        = var.subnet_ids
  transit_gateway_id = var.tgw_id
  vpc_id            = var.vpc_id
  tags = {
    Name = "hs-us-east-1-prod"
  }
}

resource "aws_ec2_transit_gateway_route_table" "hs_us_east_1_prod_rt" {
  transit_gateway_id = var.tgw_id

  tags = {
    Name = "hs-us-east-1-prod"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "hs_us_east_1_prod" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.hs_us_east_1_prod.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hs_us_east_1_prod_rt.id
}

resource "aws_ec2_transit_gateway_route" "hs_us_east_1_prod_route" {
  destination_cidr_block         = var.default_route
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hs_us_east_1_prod_rt.id
  transit_gateway_attachment_id = var.ngw_vpc_attachment_id
}

resource "aws_ec2_transit_gateway_route" "hs_us_east_1_prod_route_1" {
  destination_cidr_block         = var.data_route
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hs_us_east_1_prod_rt.id
  transit_gateway_attachment_id = var.data_vpc_attachment_id
}

#resource "aws_ec2_transit_gateway_route" "hs_us_east_1_prod_route_2" {
#  destination_cidr_block         = var.hs_us_east_1_route
#  blackhole = true
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hs_us_east_1_prod_rt.id
#}
