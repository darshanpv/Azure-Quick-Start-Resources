variable "deploy_subscription_id" {
    type        = string
    description = "Default subscription id"
 }

variable "spn_client_id" {
    type        = string
    description = "Default service principal client id"
 }

variable "spn_client_secret" {
    type        = string
    description = "Default service principal client secret"
 }
 
variable "spn_tenant_id" { 
    type        = string
    description = "Default service principal tenant id"
}

variable "resource_group_name" {
    type        = string
    description = "Default resource group name"
}

variable "storage_account_name" {
    type        = string
    description = "Default storgae_account_name"
}

variable "location" {
    type        = string
    description = "Default resources location"
}

variable "division" {
    type        = string
    description = "Default division"
}

variable "environment" {
    type        = string
    description = "Default environment"
}

variable "product" {
    type        = string
    description = "Default product"
}