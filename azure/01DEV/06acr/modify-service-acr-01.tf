resource "random_id" "random_id" {
  byte_length = 4
}

resource "azurerm_container_registry" "acr01" {
  name                     = "accut${lower(random_id.random_id.hex)}"
  resource_group_name      = azurerm_resource_group.resource_group1.name
  location                 = azurerm_resource_group.resource_group1.location
  sku                      = var.sku
  admin_enabled            = false
  #admin_username           = var.admin_username
  #admin_password           = var.admin_password


  georeplication_locations = [var.georeplication_locations_a, var.georeplication_locations_b]
  tags = merge(
    {
      "purpose"    = "${var.project}_${var.service}_${var.name}"
    },
    var.cz_tags,
  )
}