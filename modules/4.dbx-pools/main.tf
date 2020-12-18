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

data "databricks_node_type" "smallest" {
}

resource "databricks_instance_pool" "this" {
  instance_pool_name = var.pool_name
  min_idle_instances = 0
  max_capacity       = var.max_pool_size
  node_type_id       = data.databricks_node_type.smallest.id
  idle_instance_autotermination_minutes = 10
}