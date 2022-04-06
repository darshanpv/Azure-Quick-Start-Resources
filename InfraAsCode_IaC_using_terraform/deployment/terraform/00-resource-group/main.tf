#Create Resource Group
resource "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
  location = var.location

  tags = {
    division                            = var.division
    environment                         = var.environment
    product                             = var.product
  }
}