variable "ngw_vpc_cidr" {
default = "192.168.0.0/24"
}

variable "firewall_subnet_cidr" {
default = "192.168.0.128/26"
}

variable "firewall_subnet_az" {
default = "us-east-2a"
}

variable "private_subnet_cidr" {
default = "192.168.0.64/26"
}

variable "private_subnet_az" {
default = "us-east-2a"
}

variable "public_subnet_cidr" {
default = "192.168.0.0/26"
}

variable "public_subnet_az" {
default = "us-east-2a"
}

variable "tgw_id" {}

variable "data_route" {
default = "172.10.0.0/16"
}

variable "hs_us_east_1_route" {
default = "172.30.0.0/16"
}

variable "hs_us_east_1_prod_route" {
default = "172.16.0.0/16"
}

variable "hs_us_east_1_prod_route_2" {
default = "172.20.0.0/16"
}

variable "hs_us_east_1_data_id" {}

variable "hs_us_east_1_id" {}

variable "hs_us_east_1_prod_id" {}

variable "default_route" {
default = "0.0.0.0/0"
}

variable "hs_us_east_1_cidr" {
default = "172.30.0.0/16"
}

variable "hs_us_east_1_data_cidr" {
default = "172.10.0.0/16"
}

variable "hs_us_east_1_prod_cidr" {
default = "172.16.0.0/16"
}

variable "pub_data" {
default = "172.10.0.0/20"
}

variable "pub_prod" {
default = "172.16.0.0/20"
}

variable "pub_hs_us_east_1" {
default = "172.30.0.0/20"
}
