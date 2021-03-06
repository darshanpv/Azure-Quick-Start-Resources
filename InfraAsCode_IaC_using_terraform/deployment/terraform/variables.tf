variable "deploy_subscription_id" {
    type        = string
    description = "subscription id"
 }

variable "spn_client_id" {
    type        = string
    description = "service principal client id"
 }

variable "spn_client_secret" {
    type        = string
    description = "service principal client secret"
 }
 
variable "spn_tenant_id" { 
    type        = string
    description = "service principal tenant id"
}

#00-resource-group variables

variable "resource_group_name" {
    type        = string
    description = "resource group name"
}

variable "location" {
    type        = string
    description = "resources location"
}

variable "default_tags" {
    type        = map
    description = "Map of default tags"
}

#01-storage-account variables

variable "storage_account_name" {
    type        = string
    description = "storgae account name"
}

#02-databricks variables

variable "workspace_name" {
    type        = string
    description = "databricks workspace name"
}

variable "sku" {
    type        = string
    description = "databricks sku"
    default = "standard"
}

variable "cluster_name" {
    type        = string
    description = "databricks cluster_name"
}