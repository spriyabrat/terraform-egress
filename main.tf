module "ngw-vpc" {
source = "./modules/ngw-vpc"
tgw_id = module.tgw.tgw-id
hs_us_east_1_data_id = module.hs-us-east-1-data.hs_us_east_1_data_vpc_attachment_id
hs_us_east_1_id = module.hs-us-east-1.hs_us_east_1_vpc_attachment_id
hs_us_east_1_prod_id = module.hs-us-east-1-prod.hs_us_east_1_prod_vpc_attachment_id
}

module "firewall" {
source = "./modules/firewall"
firewall_subnet = module.ngw-vpc.firewall-subnet-id
ngw_vpc_id = module.ngw-vpc.ngw-vpc-id
}

module "tgw" {
source = "./modules/tgw"
}

module "hs-us-east-1-data" {
source = "./modules/hs-us-east-1-data"
tgw_id	= module.tgw.tgw-id
ngw_vpc_attachment_id = module.ngw-vpc.ngw-vpc-attachment-id
prod_vpc_attachment_id = module.hs-us-east-1-prod.hs_us_east_1_prod_vpc_attachment_id
}

module "hs-us-east-1" {
source = "./modules/hs-us-east-1"
tgw_id = module.tgw.tgw-id
ngw_vpc_attachment_id = module.ngw-vpc.ngw-vpc-attachment-id
}

module "hs-us-east-1-prod" {
source = "./modules/hs-us-east-1-prod"
tgw_id = module.tgw.tgw-id
ngw_vpc_attachment_id = module.ngw-vpc.ngw-vpc-attachment-id
data_vpc_attachment_id = module.hs-us-east-1-data.hs_us_east_1_data_vpc_attachment_id
}

#module "rollback" {
#source = "./modules/rollback"
#}
