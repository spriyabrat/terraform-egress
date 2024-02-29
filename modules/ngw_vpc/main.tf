#######################################################################
## This tf script creates egress vpc, its routes tables, subnets, routes
## vpc attachments for tgw 
## and transit gateway route table, its assocation and its routes
## public-rt&private-rt&firewall-rt
########################################################################

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.ngw_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ngw-vpc"
  }
}


# Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "ngw-igw"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.public_subnet_az

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.private_subnet_az

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "firewall_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.firewall_subnet_cidr
  availability_zone       = var.firewall_subnet_az

  tags = {
    Name = "firewall-subnet"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table" "firewall_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "firewall-rt"
  }
}

resource "aws_eip" "egress_eip" {
  vpc=true
}

resource "aws_nat_gateway" "egress_nat" {
  allocation_id = aws_eip.egress_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "ngw"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "firewall_association" {
  subnet_id      = aws_subnet.firewall_subnet.id
  route_table_id = aws_route_table.firewall_rt.id
}

resource "aws_route" "public_subnet_route" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = var.default_route
  gateway_id = aws_internet_gateway.my_igw.id
}

data "aws_vpc_endpoint" "firewall" {
  vpc_id       = aws_vpc.my_vpc.id
}

resource "aws_route" "public_rt_route_1" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = var.pub_data
  vpc_endpoint_id = data.aws_vpc_endpoint.firewall.id
  depends_on = [data.aws_vpc_endpoint.firewall]
}

resource "aws_route" "public_rt_route_2" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = var.pub_prod
  vpc_endpoint_id = data.aws_vpc_endpoint.firewall.id
}

resource "aws_route" "public_rt_route_3" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = var.pub_hs_us_east_1
  vpc_endpoint_id = data.aws_vpc_endpoint.firewall.id
}

resource "aws_route" "private_rt_route" {
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = var.default_route
  #nat_gateway_id = aws_nat_gateway.egress-nat.id
  vpc_endpoint_id = data.aws_vpc_endpoint.firewall.id
}


resource "aws_route" "firewall_rt_route_1" {
  route_table_id            = aws_route_table.firewall_rt.id
  destination_cidr_block    = var.hs_us_east_1_cidr
  transit_gateway_id = var.tgw_id
}

resource "aws_route" "firewall_rt_route_2" {
  route_table_id            = aws_route_table.firewall_rt.id
  destination_cidr_block    = var.hs_us_east_1_data_cidr
  transit_gateway_id = var.tgw_id
}

resource "aws_route" "firewall_rt_route_3" {
  route_table_id            = aws_route_table.firewall_rt.id
  destination_cidr_block    = var.hs_us_east_1_prod_cidr
  transit_gateway_id = var.tgw_id
}

resource "aws_route" "firewall_rt_route_4" {
  route_table_id            = aws_route_table.firewall_rt.id
  destination_cidr_block    = var.default_route
  nat_gateway_id = aws_nat_gateway.egress-nat.id
}

###############################

resource "aws_ec2_transit_gateway_vpc_attachment" "ngw_vpc" {
  subnet_ids        = [aws_subnet.private_subnet.id]
  transit_gateway_id = var.tgw_id
  vpc_id            = aws_vpc.my_vpc.id
  tags = {
    Name = "ngw-vpc"
  }
}

resource "aws_ec2_transit_gateway_route_table" "ngw_side_rt" {
  transit_gateway_id = var.tgw_id

  tags = {
    Name = "ngw-side-rt"
  }
}


resource "aws_ec2_transit_gateway_route_table_association" "ngw_side_rt" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.ngw_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ngw_side_rt.id
}

resource "aws_ec2_transit_gateway_route" "ngw_side_route" {
  destination_cidr_block         = var.data_route
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ngw_side_rt.id
  transit_gateway_attachment_id = var.hs_us_east_1_data_id
}

resource "aws_ec2_transit_gateway_route" "ngw_side_route_1" {
  destination_cidr_block         = var.hs_us_east_1_route
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ngw_side_rt.id
  transit_gateway_attachment_id = var.hs_us_east_1_id
}

resource "aws_ec2_transit_gateway_route" "ngw_side_route_2" {
  destination_cidr_block         = var.hs_us_east_1_prod_route
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ngw_side_rt.id
  transit_gateway_attachment_id = var.hs_us_east_1_prod_id
}

resource "aws_ec2_transit_gateway_route" "ngw_side_route_3" {
  destination_cidr_block         = var.hs_us_east_1_prod_route_2
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ngw_side_rt.id
  transit_gateway_attachment_id = var.hs_us_east_1_prod_id
}
