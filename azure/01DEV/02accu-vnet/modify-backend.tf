terraform {
  #required_version = ">= 0.12.0"
  backend "azurerm" {
    storage_account_name  = "tfstte2c1238d3"
    container_name        = "tfstte2c1238d3-tfstat1"
    access_key            = "bnBV5Xd10LOABgr21ggjKSx1w4+gDWK18cOAba8yG5rOpRUtAADQzPdAnRN5E35/oLW/X14lBl9oe4er5jvbuQ=="
    key                   = "accu-vnet-01-rg"
  }
}