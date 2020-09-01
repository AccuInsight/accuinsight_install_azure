resource "random_id" "storage_account" {
  byte_length = 4
}

# Fileshare #1, skmbpmsaccuemrmcm
resource "azurerm_storage_account" "azure1" {
  name                     = "tfstte${lower(random_id.storage_account.hex)}"
  resource_group_name      = azurerm_resource_group.resource_group1.name
  location                 = azurerm_resource_group.resource_group1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = "true"
}

resource "azurerm_storage_container" "tfstat1" {
  name                  = "${azurerm_storage_account.azure1.name}-tfstat1"
  storage_account_name  = azurerm_storage_account.azure1.name
  container_access_type = "blob"
}
