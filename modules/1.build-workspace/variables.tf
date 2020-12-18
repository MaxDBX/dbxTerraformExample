variable "location" {
  type = string
  default = "eastus2"
}

variable "tags" {
  type = map

  default = {
    Owner = "carsten.thone@databricks.com"
    OwnerEmail = "carsten.thone@databricks.com"
  }
}