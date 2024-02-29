variable "subnet_ids" {
type = list(string)
default = ["subnet-041f6cd74546a28dd", "subnet-0406de3f80b51feba"]
}

variable "vpc_id" {
default = "vpc-0a656b2ed67c44beb"
}

variable "tgw_id" {}

variable "default_route" {
default = "0.0.0.0/0"
}

variable "ngw_vpc_attachment_id" {}

variable "data_vpc_attachment_id" {}

variable "data_route" {
default = "172.10.0.0/16"
}

#variable "hs_us_east_1_route" {
#default = "172.30.0.0/16"
#}

variable "prod_rt_1" {
default = "rtb-073959b2bb4f95547"
}

variable "prod_rt_2" {
default = "rtb-035c6e50940a85d85"
}
