
resource "azurerm_resource_group" "example" {
	name = "example-resources"
	location = "West Europe"
}



resource "azurerm_virtual_network" "example" {
	name = "testvnet"
	address_space = ["10.0.0.0/16"]
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
}




resource "azurerm_subnet" "example" {
	name = "AzureFirewallSubnet"
	resource_group_name = azurerm_resource_group.example.name
	virtual_network_name = azurerm_virtual_network.example.name
	address_prefixes = ["10.0.1.0/24"]
}



resource "azurerm_public_ip" "example" {
	name = "testpip"
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	allocation_method = "Static"
	sku = "Standard"
}



resource "azurerm_firewall" "example" {
	name = "testfirewall"
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	ip_configuration {
		name = "configuration"
		subnet_id = azurerm_subnet.example.id
		public_ip_address_id = azurerm_public_ip.example.id
	}
}
























resource "azurerm_firewall_application_rule_collection" "example" {
	name = "testcollection"
	azure_firewall_name = azurerm_firewall.example.name
	resource_group_name = azurerm_resource_group.example.name
	priority = 100
	action = "Allow"
	rule {
		name = "testrule"
		source_addresses = [
			"10.0.0.0/16",
	]
	target_fqdns = [
		"*.google.com",
	]
	protocol {
		port = "443"
		type = "Https"
		}
	}
}
