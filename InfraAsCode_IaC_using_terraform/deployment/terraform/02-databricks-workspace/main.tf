#Create Databricks workspace
resource "azurerm_databricks_workspace" "workspace" {
  name = var.workspace_name
  resource_group_name = var.resource_group_name
  managed_resource_group_name = "${var.workspace_name}-workspace-rg"
  location = var.location
  sku = var.sku
  tags = var.default_tags
}

resource "databricks_user" "user" {
  user_name = "<Your oraganisation mail ID>"
  depends_on = [azurerm_databricks_workspace.workspace]
}

#Generate PAT token
resource "databricks_token" "token" {
  comment  = "Terraform Provisioning"
  // 100 day token
  lifetime_seconds = 8640000
  depends_on = [azurerm_databricks_workspace.workspace]
}

data "databricks_node_type" "smallest" {
  local_disk = true
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

#Create the cluster
resource "databricks_cluster" "cluster" {
  depends_on = [azurerm_databricks_workspace.workspace]
  cluster_name = var.cluster_name
  spark_version = data.databricks_spark_version.latest_lts.id
  node_type_id = data.databricks_node_type.smallest.id
  autotermination_minutes = 15
  autoscale {
    min_workers = 1
    max_workers = 8
  }
  spark_env_vars = {
    "PYSPARK_PYTHON" : "/databricks/python3/bin/python3"
  }
  spark_conf = {
    "spark.databricks.repl.allowedLanguages": "sql,python,r"
  }
}