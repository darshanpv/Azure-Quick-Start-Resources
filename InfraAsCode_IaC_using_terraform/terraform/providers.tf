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
    subscription_id = "3774059e-993b-4879-9c1c-1937b534d0a3"
    client_id = var.spn_client_id
    client_secret = var.spn_client_secret
    tenant_id = var.spn_tenant_id
}