// workspace will be used to create Databricks provider in 6.dbx-cluster, 3.6.dbx-cluster-policies and 2.dbx-usergroups modules
output "workspace_id" {
  value = azurerm_databricks_workspace.this.id
}