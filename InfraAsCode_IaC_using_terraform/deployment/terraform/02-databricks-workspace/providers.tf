# You must specify source address in each module which requires databricks provider

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
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
  host = azurerm_databricks_workspace.workspace.workspace_url
  azure_workspace_resource_id = azurerm_databricks_workspace.workspace.id
  azure_client_id = var.spn_client_id
  azure_client_secret = var.spn_client_secret
  azure_tenant_id = var.spn_tenant_id
  azure_use_msi = true
}