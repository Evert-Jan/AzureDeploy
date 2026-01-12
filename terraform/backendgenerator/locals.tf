locals {
  subscriptionid = data.azurerm_client_config.current.subscription_id
  tenantid       = data.azurerm_client_config.current.tenant_id
  givennamelower = lower(data.azuread_user.current_user.given_name)
  lastnamelower  = lower(data.azuread_user.current_user.surname)
  upntrimmed     = replace(lower(data.azuread_user.current_user.user_principal_name), "/[^a-z0-9]/", "")
  statergname    = "${local.upntrimmed}-state-rg"
  statesaname    = "${substr(local.upntrimmed, 0, 10)}${random_id.sa_suffix.dec}"
  location       = "westeurope"
}
locals {
  environment = "poc"
  tags = {
    environment = local.environment
    location    = local.location
    deployed-by = data.azuread_user.current_user.user_principal_name
    owner       = data.azuread_user.current_user.user_principal_name
    managed     = "Local Terraform State"
    git         = "https://github.com/Evert-Jan/AzureDeploy/tree/main/terraform/backendgenerator"
  }
}

resource "random_id" "sa_suffix" {
  byte_length = 2

}
output "upntrimmed" {
  value = local.upntrimmed
}

output "statergname" {
  value = local.statergname
}

output "statesaname" {
  value = local.statesaname
}

output "prefix" {
  value = substr(local.upntrimmed, 0, 5)
}
