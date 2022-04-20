terraform {
  backend "azurerm" {
    resource_group_name = "aa-eun-dev-availableapi-tfstate-rg"
  }
  required_version = ">= 1.1.3"
}
