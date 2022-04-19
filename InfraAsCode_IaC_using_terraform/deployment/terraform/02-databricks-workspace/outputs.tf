output "dbks_host_out" {
    value = "https://${azurerm_databricks_workspace.workspace.workspace_url}/"
}

output "dbks_token_out" {
  value = databricks_token.token.token_value
  sensitive = true
}

output "dbks_cluster_id_out" {
  value = databricks_cluster.cluster.id
}
