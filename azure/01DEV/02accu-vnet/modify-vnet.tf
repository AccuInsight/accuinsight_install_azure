

# 첫번째 vNet 생성하기
resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.project}_${var.service}_${var.name}_vnet"
  resource_group_name = azurerm_resource_group.resource_group1.name
  location            = azurerm_resource_group.resource_group1.location
  address_space       = var.accu_address_space
}