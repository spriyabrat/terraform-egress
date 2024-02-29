variable "firewall_subnet" {}

variable "ngw_vpc_id" {}

variable "ip_set_definition" {
  type    = list(string)
  default = ["172.10.0.0/20", "172.30.0.0/20", "172.16.0.0/20", "172.16.16.0/20"]
}

variable "targets_file" {
  type    = string
  default = "./modules/firewall/domain_list.txt" # Adjust the default value based on your file path
}

variable "generated_rules_type" {
  type    = string
  default = "ALLOWLIST"
}

variable "target_types" {
  type    = list(string)
  default = ["HTTP_HOST", "TLS_SNI"]
}

variable "ip_address_type" {
default = "IPV4"
}
