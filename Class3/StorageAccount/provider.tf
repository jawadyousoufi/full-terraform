provider "azurerm" {
	features {}
}


resource "azurerm_resource_group" "example" {
	name = "example-resources"
	location = "West Europe"
}

resource "random_string" "random" {
	length = 14
	special = false
	upper = false
}



resource "azurerm_storage_account" "example" {
	name = "example${random_string.random.result}"
	resource_group_name = azurerm_resource_group.example.name
	location = azurerm_resource_group.example.location
	account_tier = "Standard"
	account_replication_type = "LRS"
}


resource "azurerm_storage_container" "example" {
	name = "content"
	storage_account_name = azurerm_storage_account.example.name
	container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
	name = "secret_file.gz"
	storage_account_name = azurerm_storage_account.example.name
	storage_container_name = azurerm_storage_container.example.name
	type = "Block"
	source = "secret_file.gz"
}
