# Create our workspace
module "base_workspace" {
  source = "./modules/1.build-workspace"
  location = "uksouth"
}

// GROUPS
module "marketing_group" {
  source = "./modules/2.dbx-usergroups"
  group_name = "marketing"
  workspace_id = module.base_workspace.workspace_id
}

// create a group for "engineering team"
module "engineering_group" {
  source = "./modules/2.dbx-usergroups"
  group_name = "engineering"
  workspace_id = module.base_workspace.workspace_id
}

// POOLS

// Create a pool for "marketing team"
module "marketing_pool" {
  source = "./modules/4.dbx-pools"
  workspace_id = module.base_workspace.workspace_id
  pool_name = "marketing_pool"
  max_pool_size = 10
}

// create a pool for "engineering team"
module "engineering_pool" {
  source = "./modules/4.dbx-pools"
  workspace_id = module.base_workspace.workspace_id
  pool_name = "engineering_pool"
  max_pool_size = 30
}

// Attach policies to groups
module "marketing_compute_policy" {
  source = "./modules/3.dbx-cluster-policies"
  group_name= module.marketing_group.group_name
  workspace_id = module.base_workspace.workspace_id
  pool_id = module.marketing_pool.pool_id
    policy_overrides = {
        // only marketing guys will benefit from delta cache this way
        "spark_conf.spark.databricks.io.cache.enabled": {
          "type" : "unlimited"
          "isOptional": true
          "defaultValue": "true"
        },
    }
}

module "engineering_compute_policy" {
  source = "./modules/3.dbx-cluster-policies"
  group_name = module.engineering_group.group_name
  workspace_id = module.base_workspace.workspace_id
  pool_id = module.engineering_pool.pool_id
    policy_overrides = {
        "dbus_per_hour" : {
            "type" : "range",
            // only engineering guys can spin up big clusters
            "maxValue" : 50
        },
    }
}

// CREATE CLUSTERS
module "databricks_engineering_cluster" {
  source = "./modules/5.dbx-cluster"
  workspace_id = module.base_workspace.workspace_id
  group_name = module.engineering_group.group_name
  pool_id = module.engineering_pool.pool_id
  policy_id = module.engineering_compute_policy.policy_id
}

module "databricks_marketing_cluster" {
  source = "./modules/5.dbx-cluster"
  workspace_id = module.base_workspace.workspace_id
  group_name = module.marketing_group.group_name
  pool_id = module.marketing_pool.pool_id
  policy_id = module.marketing_compute_policy.policy_id
}

