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

// note: When you change the cluster configuration,
// make sure they adhere to the policy defined in 3.dbx-cluster-policies
// else you will get a policy validation error.
resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = format("%s_cluster", var.group_name)
  spark_version           = "7.3.x-scala2.12"
  autotermination_minutes = 20
  instance_pool_id = var.pool_id
  policy_id = var.policy_id

  autoscale {
    min_workers = 1
    max_workers = 5
  }

  custom_tags = {
            Team : var.group_name
        }
}