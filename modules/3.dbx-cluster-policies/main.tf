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

// local variable that contains a default cluster policy
locals {
    default_policy = {
        "dbus_per_hour" : {
            "type" : "range",
            "maxValue" : 10
        },
        "autotermination_minutes": {
            "type": "fixed",
            "value": 20,
            "hidden": true
        },
        "custom_tags.Team" : {
            "type" : "fixed",
            "value" : var.group_name
        },
        "instance_pool_id" : {
          "type" : "fixed"
          "value": var.pool_id
        }
    }
}

resource "databricks_cluster_policy" "fair_use" {
    name = "${var.group_name} cluster policy"
    definition = jsonencode(merge(local.default_policy, var.policy_overrides))
}

resource "databricks_permissions" "can_use_cluster_policyinstance_profile" {
    cluster_policy_id = databricks_cluster_policy.fair_use.id
    access_control {
        group_name       = var.group_name
        permission_level = "CAN_USE"
    }
}

