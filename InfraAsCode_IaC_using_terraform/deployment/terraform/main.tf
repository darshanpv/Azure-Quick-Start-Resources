locals {
    resource_group_name = var.resource_group_name
    location = var.location
    default_tags = var.default_tags
}
  
module "resource_group" {
    source = "./00-resource-group"
    resource_group_name = local.resource_group_name
    location = local.location
    default_tags = local.default_tags
}

module "storage_account" {
    source = "./01-storage-account"
    storage_account_name = var.storage_account_name
    resource_group_name = module.resource_group.resource_group_name_out
    location = local.location
}
  
  
module "databricks_workspace"{
    source = "./02-databricks-workspace"
    workspace_name = var.workspace_name
    resource_group_name = local.resource_group_name
    location = local.location
    sku = var.sku
    cluster_name = var.cluster_name
    spn_client_id = var.spn_client_id
    spn_client_secret = var.spn_client_secret
    spn_tenant_id = var.spn_tenant_id
    deploy_subscription_id = var.deploy_subscription_id
    default_tags = local.default_tags
}