# 쿠버네티스 클러스터 생성
resource "azurerm_kubernetes_cluster" "k8s" {
    name = "${var.project}_${var.service}_${var.name}"
    resource_group_name      = azurerm_resource_group.resource_group1.name
    location                 = azurerm_resource_group.resource_group1.location
    dns_prefix          = var.dns_prefix
    node_resource_group = "${azurerm_resource_group.resource_group1.name}-nodepool-rg"

    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }

    default_node_pool {
        name                    = "nodepoola"
        node_count              = var.agent_count
        vm_size                 = var.vm_size
        type                    = "VirtualMachineScaleSets"
        vnet_subnet_id          = azurerm_subnet.subnet-01.id
#        node_labels             = var.default_node_pool_labels
#        node_taints             = var.default_node_pool.taints
        enable_auto_scaling     = var.default_node_pool_cluster_auto_scaling
        min_count               = var.default_node_pool_cluster_auto_scaling_min_count
        max_count               = var.default_node_pool_cluster_auto_scaling_max_count
        enable_node_public_ip   = false
    }

    network_profile {
        load_balancer_sku  = "standard"
        outbound_type      = "loadBalancer"
        network_plugin     = var.aks_network_plugin
        network_policy     = var.network_policy
    #    pod_cidr           = var.pod_cidr
        dns_service_ip     = var.aks_dns_service_ip
        docker_bridge_cidr = var.aks_docker_bridge_cidr
        service_cidr       = var.aks_service_cidr
  }

    service_principal {
        client_id     = var.client_id
        client_secret = var.client_secret
    }

    addon_profile {
        oms_agent {
        enabled                    = true
        log_analytics_workspace_id = azurerm_log_analytics_workspace.k8s.id
        }
    }
}

resource "azurerm_kubernetes_cluster_node_pool" "nodepoolb" {
  name                  = "nodepoolb"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = "Standard_D4_v2"
  node_count            = 3

  tags = {
    Environment = "Production"
  }
}

# Log Analytics Workspace 생성
resource "azurerm_log_analytics_workspace" "k8s" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
    location            = azurerm_resource_group.resource_group1.location
    resource_group_name = azurerm_resource_group.resource_group1.name
    sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "k8s" {
    solution_name           = "ContainerInsights"
    location                = azurerm_resource_group.resource_group1.location
    resource_group_name     = azurerm_resource_group.resource_group1.name
    workspace_resource_id   = azurerm_log_analytics_workspace.k8s.id
    workspace_name          = azurerm_log_analytics_workspace.k8s.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}

resource "azurerm_subnet" "subnet-01" {
  name = "${var.project}_${var.service}_${var.name}_subnet1"
  resource_group_name       =  "accu_vnet_01_rg"
  virtual_network_name      =  "accu_vnet_01_vnet"
  address_prefix            =  "10.10.201.0/24" 

#  network_security_group_id = azurerm_network_security_group.k8s.id
}

# Random ID 생성
resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}