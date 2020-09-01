provider "azurerm" { 
    version = "~>2.0"
    features {}
}

# Create a resource group if it doesn't exist
locals { 
  resource_group_name     = "${var.project}_${var.service}_${var.name}_rg"
  resource_group_location = var.resource_group_location
}

resource "azurerm_resource_group" "resource_group1" {
   name     = local.resource_group_name
   location = local.resource_group_location
   tags = merge(
    {
        "purpose"    = "${var.project}_${var.service}_${var.name}"
    },
    var.cz_tags,
  )
}
