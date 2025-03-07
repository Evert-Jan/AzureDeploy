locals {
  subscriptionid = data.azurerm_client_config.current.subscription_id
  tenantid       = data.azurerm_client_config.current.tenant_id
  givennamelower = lower(data.azuread_user.current_user.given_name)
  lastnamelower  = lower(data.azuread_user.current_user.surname)
  upntrimmed     = replace(replace(replace(lower(data.azuread_user.current_user.user_principal_name), "@", ""), ".", ""), "-", "")
  statergname    = "${local.upntrimmed}-state-rg"
  statesaname    = "${substr(local.upntrimmed, 0, 10)}${random_id.sa_suffix.dec}"
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
