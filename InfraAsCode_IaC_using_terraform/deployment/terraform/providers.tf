terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.0.0"
        }

        databricks = {
            source = "databrickslabs/databricks"
            version = "0.5.4"
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

provider "databricks" {
}