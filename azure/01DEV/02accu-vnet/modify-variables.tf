# Resource Group
variable "project"                        { default = "accu"}
variable "service"                        { default = "vnet"}
variable "name"                           { default = "01"}
variable "resource_group_location"        { default = "koreacentral"}
variable "cz_tags" {}
variable "accu_address_space"             { default = ["10.10.0.0/16"]}