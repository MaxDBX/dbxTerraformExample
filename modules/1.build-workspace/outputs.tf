// workspace_id will be used to create Databricks resources in modules 2, 3, 4 and 6
output "workspace_id" {
  value = azurerm_databricks_workspace.this.id
}