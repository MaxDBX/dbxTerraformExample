variable "group_name" {
  type = string
}

variable "workspace_id" {
  type = string
}

variable "allow_cluster_create" {
  type = bool
  default = false
}

variable "allow_instance_pool_create" {
  type = bool
  default = false
}