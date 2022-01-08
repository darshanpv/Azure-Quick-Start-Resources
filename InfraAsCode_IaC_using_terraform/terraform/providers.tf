terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "2.37.0"
        }
    }
}

provider "azurerm"  {
    features {}
    subscription_id = "<YOUR_SUBSCRIPTION_ID>"
    client_id = var.spn_client_id
    client_secret = var.spn_client_secret
    tenant_id = var.spn_tenant_id
}
