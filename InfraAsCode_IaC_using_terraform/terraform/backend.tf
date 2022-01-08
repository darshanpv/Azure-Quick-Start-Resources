terraform {
    backend "azurerm" {
        storage_account_name = "tefmstatefilessa"
        container_name = "tf-state-files"
        key = "aug-analytics-tf.tfstate"
    }
}