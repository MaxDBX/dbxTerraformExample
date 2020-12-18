// define name for group in databricks workspace
variable "group_name" {
    description = "Name belonging to a Databricks group"
}

// Optionally adding override to standard cluster policy
variable "policy_overrides" {
    description = "Cluster policy overrides"
}

// Need databricks workspace ID to create our databricks provider
variable "workspace_id" {
    type = string
}

variable "pool_id" {
    type = string
}