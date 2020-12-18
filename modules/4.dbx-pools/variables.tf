variable "workspace_id" {
  type = string
  description = "id of the Databricks workspace"
}

variable "pool_name" {
  type = string
  description = "Name of the pool"
}

// Optionally adding override to standard cluster policy
variable "max_pool_size" {
    type = number
    description = "max number of VM's in this pool"
}