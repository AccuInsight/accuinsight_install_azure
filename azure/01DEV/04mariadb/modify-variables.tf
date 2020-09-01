# Resource Group
variable "project"                        { default = "accu"}
variable "service"                        { default = "mariadb"}
variable "name"                           { default = "01"}
variable "resource_group_location"        { default = "koreacentral"}
variable "cz_tags" {}

# sku_name to be one of [B_Gen5_1 B_Gen5_2 GP_Gen5_2 GP_Gen5_4 GP_Gen5_8 GP_Gen5_16 GP_Gen5_32 MO_Gen5_2 MO_Gen5_4 MO_Gen5_8 MO_Gen5_16]
variable "mariadb1_sku_name"                       { default = "B_Gen5_1" }
variable "mariadb1_storage_mb"                     { default = "102400"}
variable "mariadb1_backup_retention_days"          { default = "30"}
variable "mariadb1_geo_redundant_backup_enabled"   { default = "false"}
variable "mariadb1_public_network_access_enabled"  { default = "true"}
variable "mariadb1_auto_grow_enabled"              { default = "false"}
variable "mariadb1_administrator_login"            { default = "skpsqladminun"}
variable "mariadb1_administrator_login_password"   { default = "p0QSh(K1CoRA3!"}
variable "mariadb1_mariadb_version"                { default = "10.2"}
variable "mariadb1_ssl_enforcement_enabled"        { default = "true"}
  
locals {
  mariadb1_firewall_fules = {
    "gooeldns"     = { name = "google_dns1", start_ip_address ="8.8.8.8", end_ip_address = "8.8.8.9" },
    "cloudflare"     = { name = "cloudflase_dns1", start_ip_address ="1.1.1.1", end_ip_address = "1.1.1.1" },
  }
}