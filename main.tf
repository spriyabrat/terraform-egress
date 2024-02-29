module "ngw_vpc" {
source = "./modules/ngw_vpc"
tgw_id = module.tgw.tgw_id
hs_us_east_1_data_id = module.hs_us_east_1_data.hs_us_east_1_data_vpc_attachment_id
hs_us_east_1_id = module.hs_us_east_1.hs_us_east_1_vpc_attachment_id
hs_us_east_1_prod_id = module.hs_us_east_1_prod.hs_us_east_1_prod_vpc_attachment_id
}

module "firewall" {
source = "./modules/firewall"
firewall_subnet = module.ngw_vpc.firewall_subnet_id
ngw_vpc_id = module.ngw_vpc.ngw_vpc_id
}

module "tgw" {
source = "./modules/tgw"
}

module "hs_us_east_1_data" {
source = "./modules/hs_us_east_1_data"
tgw_id	= module.tgw.tgw_id
ngw_vpc_attachment_id = module.ngw_vpc.ngw_vpc_attachment_id
prod_vpc_attachment_id = module.hs_us_east_1_prod.hs_us_east_1_prod_vpc_attachment_id
}

module "hs_us_east_1" {
source = "./modules/hs_us_east_1"
tgw_id = module.tgw.tgw_id
ngw_vpc_attachment_id = module.ngw_vpc.ngw_vpc_attachment_id
}

module "hs_us_east_1_prod" {
source = "./modules/hs_us_east_1_prod"
tgw_id = module.tgw.tgw_id
ngw_vpc_attachment_id = module.ngw_vpc.ngw_vpc_attachment_id
data_vpc_attachment_id = module.hs_us_east_1_data.hs_us_east_1_data_vpc_attachment_id
}

#module "rollback" {
#source = "./modules/rollback"
#}
