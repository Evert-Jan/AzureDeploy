locals {
  environment = "poc"
  location    = "westeurope"
  tags = {
    environment = local.environment
    location    = local.location
    deployed-by = data.azuread_user.current_user.user_principal_name
    owner       = data.azuread_user.current_user.user_principal_name
    managed     = "Local Terraform State"
    git         = "https://github.com/topicusonderwijs/eduarte-alles-mag-dinsdag/terraform/backendgenerator"
  }
}


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