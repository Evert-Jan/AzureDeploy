resource "azurerm_resource_group" "tfstate" {
  name     = local.statergname
  location = local.location
  tags     = local.tags
}


resource "azurerm_storage_account" "tfstate" {
  name                     = local.statesaname
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  # storage_account_name  = azurerm_storage_account.tfstate.name
  storage_account_id = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}