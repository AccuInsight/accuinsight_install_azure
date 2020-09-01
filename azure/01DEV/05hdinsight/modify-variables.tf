# Resource Group
variable "project"                          { default = "accu"}
variable "service"                          { default = "hdinsight"}
variable "name"                             { default = "01"}
variable "resource_group_location"          { default = "koreacentral"}
variable "cz_tags"                          {}


# Inormation for hdinsight_cluster_01
variable "hdinsight_cluster_01_version"                                 { default = "3.6" }
variable "hdinsight_cluster_01_tier"                                    { default = "Standard" }
# Inormation for hdinsight_cluster_01_Gateway
variable "hdinsight_cluster_01_gateway_username"                        { default = "accuadminiadq" }
variable "hdinsight_cluster_01_gateway_password"                        { default = "0adoakQ9dQsa" }
# Inormation for hdinsight_cluster_01_Headnode
variable "hdinsight_cluster_01_head_node_vm_size"                       { default = "Standard_D13_V2" }
variable "hdinsight_cluster_01_head_node_username"                      { default = "accuadminiadq" }
variable "hdinsight_cluster_01_head_node_password"                      { default = "0adoakQ9dQsa" }
variable "hdinsight_cluster_01_head_node_target_instance_count"         { default = "3" }
# Inormation for hdinsight_cluster_01_Workernode
variable "hdinsight_cluster_01_worker_node_vm_size"                     { default = "Standard_D13_V2" }
variable "hdinsight_cluster_01_worker_node_username"                    { default = "accuadminiadq" }
variable "hdinsight_cluster_01_worker_node_password"                    { default = "0adoakQ9dQsa" }
# Inormation for hdinsight_cluster_01_Zookeeper
variable "hdinsight_cluster_01_zookeeper_node_vm_size"                  { default = "Standard_D13_V2" }
variable "hdinsight_cluster_01_zookeeper_node_username"                 { default = "accuadminiadq" }
variable "hdinsight_cluster_01_zookeeper_node_password"                 { default = "0adoakQ9dQsa" }