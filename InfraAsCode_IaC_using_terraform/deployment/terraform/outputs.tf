output "resource_group_name" {
  value = module.resource_group.resource_group_name_out
}

output "storage_account_name" {
  value = module.storage_account.storage_account_name_out
}

output "databricks_host" {
  value = module.databricks_workspace.dbks_host_out
}

output "databricks_token" {
  value = module.databricks_workspace.dbks_token_out
  sensitive = true
}

output "databricks_cluster_id" {
  value = module.databricks_workspace.dbks_cluster_id_out
}