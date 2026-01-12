variable "location" { default = "Central India" }
variable "rg_name" { default = "rg-3tier-prod" }
variable "vnet_cidr" { default = "10.0.0.0/16" }

variable "subnet_id" {
  type = string
  description = "Subnet ID for Application Gateway"
}