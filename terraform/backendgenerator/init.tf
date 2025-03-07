# Provider version during making of code.
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
    random = {
      source = "hashicorp/random"
    }
    null = {
      source = "hashicorp/null"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}

provider "azurerm" {
  subscription_id = nonsensitive(replace(lower(module.shell_data_getsubscription.stdout), "\"", "") )
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
