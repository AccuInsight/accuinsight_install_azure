terraform {
  #required_version = ">= 0.12.0"
  backend "azurerm" {
    storage_account_name  = "tfstte2c1238d3"
    container_name        = "tfstte2c1238d3-tfstat1"
    access_key            = "bnBV5Xd10LOABgr21ggjKSx1w4+gDWK18cOAba8yG5rOpRUtAADQzPdAnRN5E35/oLW/X14lBl9oe4er5jvbuQ=="
    key                   = "accu-hdinsight-rg"  # modify-variables.tf 파일의 variable "resource_group_name"          { default = "mariadb-rg"} 이부분과 동일하게 설정한다. 
  }
} 