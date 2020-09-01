# Resource Group
variable "project"                      { default = "accu"}
variable "service"                      { default = "arc"}
variable "name"                         { default = "01"}
variable "resource_group_location"      { default = "koreacentral"}
variable "cz_tags"                      {}

variable "sku"                          { default = "Premium"}
variable "georeplication_locations_a"   { default = "East US"}
variable "georeplication_locations_b"   { default = "West Europe"}

variable "admin_enabled"                { default = "false"}
#variable "admin_username"               { default = "accuadminis"}
#variable "admin_password"               { default = "a0as9dADAF!@#!K39a"}

