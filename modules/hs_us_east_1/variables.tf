
variable "subnet_ids" {
type = list(string)
default = ["subnet-076f60e7021435a07"]
}

variable "vpc_id" {
default = "vpc-0064a484b306dedd7"
}

variable "tgw_id" {}

variable "default_route" {
default = "0.0.0.0/0"
}

variable "ngw_vpc_attachment_id" {}

variable "route_table_id" {
default = "rtb-0c60804bd32ed1b2a"
}
