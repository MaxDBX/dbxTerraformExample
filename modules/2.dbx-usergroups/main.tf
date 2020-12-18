terraform {
  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
      version = "0.2.9"
    }
  }
}

provider "databricks" {
  azure_workspace_resource_id = var.workspace_id
}

// Create a databricks group using a name defined in variables.tf
resource "databricks_group" "this" {
  display_name = var.group_name
  allow_cluster_create = false
  allow_instance_pool_create = false
}