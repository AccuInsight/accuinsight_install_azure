data "azurerm_virtual_network" "vnet1" {
  name                = "accu_vnet_01_vnet"
  resource_group_name = "accu_vnet_01_rg"
}

## variables for AKS
# Resource Group
variable "project"                        { default = "accu"}
variable "service"                        { default = "aks"}
variable "name"                           { default = "01"}
variable "resource_group_location"        { default = "koreacentral"}
variable "cz_tags" {}

### 생성을 위한 계정 정보 입력
variable "client_id" {
    default = "9e3476c9-dfba-4deb-a1fd-0bb9902297ba"
}
variable "client_secret" {
    default = "JYfXuDB~EI-e1IOBucVd8V5pYUOX~GJWSS"
}

# variable location {
#     default = var.resource_group_location
# }

##################################################################
# 쿠버네티스 구성 정보
variable "kubernetes_version" {
  description = "The version of Kubernetes."
  default     = "1.11.5"
}
# 쿠버네티스 구성 정보
##################################################################

##################################################################
# vNet,쿠버네티스 생성 네트워크 정보
variable "aks_network_plugin" {
    default     = "kubenet"
}

variable "network_policy" {
    default     = "calico"
}

variable "pod_cidr" {
    default     = "10.232.0.0/23"
}

variable "aks_service_cidr" {
  description = "A CIDR notation IP range from which to assign service cluster IPs."
  default     = "192.168.0.0/20"
}

variable "aks_dns_service_ip" {
  description = "Containers DNS server IP address."
  default     = "192.168.0.10"
}

variable "aks_docker_bridge_cidr" {
  description = "A CIDR notation IP for Docker bridge."
  default     = "172.17.0.1/16"
}

variable "dns_prefix" {
    default = "accu"
}
# vNet,쿠버네티스 생성 네트워크 정보
##################################################################

##################################################################
# nodepool 구성정보 

variable "vm_size" {
    default = "Standard_D4_v2"
        # D2s_v3 : 2vCore/8GB/
        # D4s_v3 : 4vCore/16GB/
        # B4ms   : 4vCore/16GB/
}

variable "agent_count" {
    default = 1
}

variable "ssh_public_key" {
    default = "../common/authorized_keys"
}

variable "default_node_pool_labels" {
    default = "worker"
}

variable "default_node_pool_taints" {
    default = "taint"
}

variable "default_node_pool_cluster_auto_scaling" {
    default = "true"
}
variable "default_node_pool_cluster_auto_scaling_min_count" {
    default = "1"
}
variable "default_node_pool_cluster_auto_scaling_max_count" {
    default = "2"
}
# nodepool 구성정보 
##################################################################

##################################################################
# Log Analytics workspace
variable log_analytics_workspace_name {
    default = "aks-01-LogAnalyticsWorkspaceName"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "koreacentral"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}
# Log Analytics workspace
##################################################################