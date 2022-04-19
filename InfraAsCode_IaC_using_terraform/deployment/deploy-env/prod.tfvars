# resource group
resource_group_name = "data-hub-prod-rsg"
location = "North Europe"

default_tags = {
	division = "finance"
	environment = "prod"
	product = "demo"
}

# storage account
storage_account_name = "datahubprod"

# databricks
workspace_name = "tgi-dbks-neu-prod"
sku = "standard"
cluster_name = "tgi-alto-cluster-prod"