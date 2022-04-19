# resource group
resource_group_name = "data-hub-dev-rsg"
location = "North Europe"

default_tags = {
	division = "finance"
	environment = "dev"
	product = "demo"
}

# storage account
storage_account_name = "datahubdev"

# databricks
workspace_name = "tgi-dbks-neu-dev"
sku = "standard"
cluster_name = "tgi-alto-cluster-dev"
