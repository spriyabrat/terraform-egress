variable "subnet_ids" {
type = list(string)
default = ["subnet-09e48344679351145", "subnet-014996798e051aeb8", "subnet-047d0ca9495f50b3e"]
}

variable "vpc_id" {
default = "vpc-0f2e119b078269329"
}

variable "tgw_id" {}

variable "default_route" {
default = "0.0.0.0/0"
}

variable "ngw_vpc_attachment_id" {}

variable "prod_route" {
default = "172.16.0.0/16"
}

variable "prod_vpc_attachment_id" {}

variable "hs_us_east_1_route" {
default = "172.30.0.0/16"
} 
