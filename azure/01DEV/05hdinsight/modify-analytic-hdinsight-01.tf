resource "random_id" "storage_account" {
  byte_length = 4
}

resource "azurerm_storage_account" "storageaccount01" {
   name                     = "accut${lower(random_id.storage_account.hex)}"
   resource_group_name      = local.resource_group_name
   location                 = local.resource_group_location
   account_tier             = "Standard"
   account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storageaccount01_container_01" {
  name                  = "container01"
  storage_account_name  = azurerm_storage_account.storageaccount01.name
  container_access_type = "private"
}

resource "azurerm_hdinsight_interactive_query_cluster" "hdinsight_cluster_01" {
  name                  = "accut${lower(random_id.storage_account.hex)}"
  resource_group_name   = azurerm_storage_account.storageaccount01.resource_group_name
  location              = azurerm_storage_account.storageaccount01.location
  cluster_version       = var.hdinsight_cluster_01_version
  tier                  = var.hdinsight_cluster_01_tier

  component_version {
    interactive_hive = "2.1"
  }

  gateway {
    enabled  = true
    username = var.hdinsight_cluster_01_gateway_username
    password = var.hdinsight_cluster_01_gateway_password
  }

  storage_account {
    storage_container_id = azurerm_storage_container.storageaccount01_container_01.id
    storage_account_key  = azurerm_storage_account.storageaccount01.primary_access_key
    is_default           = true
  }

  roles {
    head_node {
      vm_size  = var.hdinsight_cluster_01_head_node_vm_size
      username = var.hdinsight_cluster_01_head_node_username
      password = var.hdinsight_cluster_01_head_node_password
    }

    worker_node {
      vm_size  =              var.hdinsight_cluster_01_head_node_vm_size
      username =              var.hdinsight_cluster_01_head_node_username
      password =              var.hdinsight_cluster_01_head_node_password
      target_instance_count = var.hdinsight_cluster_01_head_node_target_instance_count
    }

    zookeeper_node {
      vm_size  = var.hdinsight_cluster_01_head_node_vm_size
      username = var.hdinsight_cluster_01_head_node_username
      password = var.hdinsight_cluster_01_head_node_password
    }
  }
}