terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.0.0"
        }
    }
}

provider "azurerm"  {
    features {}
    subscription_id = var.deploy_subscription_id
    client_id = var.spn_client_id
    client_secret = var.spn_client_secret
    tenant_id = var.spn_tenant_id
}

module "resource_group" {
    source = "./00-resource-group"
    resource_group_name = var.resource_group_name
    location = var.location
    division = var.division
    environment = var.environment
    product = var.product
}

module "storage_account" {
    source = "./01-storage-account"
    storage_account_name = var.storage_account_name
    resource_group_name = module.resource_group.resource_group_name_out
    location = var.location
}
