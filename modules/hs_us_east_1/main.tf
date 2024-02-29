#######################################################################
## For  HS-US-EAST-1 VPC
## This tf script creates tgw entry in private route table and 
## vpc attachments for tgw
## and transit gateway route table, its assocation and its routes
########################################################################

resource "aws_route" "private_route_hs_us_east_1_vpc" {
  route_table_id            = var.route_table_id
  destination_cidr_block    = var.default_route
  transit_gateway_id = var.tgw_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "hs_us_east_1" {
  subnet_ids        = var.subnet_ids
  transit_gateway_id = var.tgw_id
  vpc_id            = var.vpc_id
  tags = {
    Name = "hs-us-east-1"
  }
}

resource "aws_ec2_transit_gateway_route_table" "hs_us_east_1_rt" {
  transit_gateway_id = var.tgw_id

  tags = {
    Name = "hs-us-east-1"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "hs_us_east_1" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.hs_us_east_1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hs_us_east_1_rt.id
}

resource "aws_ec2_transit_gateway_route" "hs_us_east_1_route" {
  destination_cidr_block         = var.default_route
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hs_us_east_1_rt.id
  transit_gateway_attachment_id = var.ngw_vpc_attachment_id
}
