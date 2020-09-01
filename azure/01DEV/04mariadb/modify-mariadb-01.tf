resource "random_id" "storage_account" {
  byte_length = 4
}

######## 1st Database Mraidb
resource "azurerm_mariadb_server" "mariadb01" {
  name                     = "accut${lower(random_id.storage_account.hex)}"
  resource_group_name      = azurerm_resource_group.resource_group1.name
  location                 = azurerm_resource_group.resource_group1.location

# sku_name to be one of [B_Gen5_1 B_Gen5_2 GP_Gen5_2 GP_Gen5_4 GP_Gen5_8 GP_Gen5_16 GP_Gen5_32 MO_Gen5_2 MO_Gen5_4 MO_Gen5_8 MO_Gen5_16]
  sku_name = "B_Gen5_1"

  storage_mb                    = var.mariadb1_storage_mb
  backup_retention_days         = var.mariadb1_backup_retention_days
  geo_redundant_backup_enabled  = var.mariadb1_geo_redundant_backup_enabled
  public_network_access_enabled = var.mariadb1_public_network_access_enabled
  auto_grow_enabled             = var.mariadb1_auto_grow_enabled
  administrator_login           = var.mariadb1_administrator_login
  administrator_login_password  = var.mariadb1_administrator_login_password
  version                       = var.mariadb1_mariadb_version
  ssl_enforcement_enabled       = var.mariadb1_ssl_enforcement_enabled
  #infrastructure_encryption_enabled = true
  #geo_redundant_backup_enabled  = false

  tags = merge(
    var.cz_tags,
    {
    }
  )
}

resource "azurerm_mariadb_database" "mariadb01-database001" {
  #name                      = "${var.project}_${var.service}_${var.name}_01"  #  invalid value for name (name must be 1 - 64 characters long, and contain only letters, numbers and underscores)
  name                      = "database01"
  server_name               = azurerm_mariadb_server.mariadb01.name
  resource_group_name       = azurerm_mariadb_server.mariadb01.resource_group_name
  
  charset                   = "utf8"
  collation                 = "utf8_general_ci"
}
resource "azurerm_mariadb_firewall_rule" "mariadb01-database001-fireall" {  #  invalid value for name (name must be 1 - 64 characters long, and contain only letters, numbers and underscores)
  for_each                  = local.mariadb1_firewall_fules
  name                      = each.key
  server_name               = azurerm_mariadb_server.mariadb01.name
  resource_group_name       = azurerm_mariadb_server.mariadb01.resource_group_name
  
  start_ip_address          = each.value.start_ip_address
  end_ip_address            = each.value.end_ip_address
}