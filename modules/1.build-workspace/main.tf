terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "mthoneRG"
  location = var.location
  tags = var.tags
}

resource "azurerm_databricks_workspace" "this" {
  location = var.location
  name = "dbx-mthone-tf"
  resource_group_name = azurerm_resource_group.rg.name
  sku = "premium"
  tags = var.tags
}