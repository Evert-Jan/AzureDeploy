resource "local_file" "tf_backend" {
  content  = <<-EOF
terraform {
  backend "azurerm" {
    container_name       = "tfstate"
    key                  = "${local.givennamelower}/terraform.tfstate"
    resource_group_name  = "${local.statergname}"
    storage_account_name = "${local.statesaname}"
    subscription_id      = "${local.subscriptionid}"
    tenant_id            = "${local.tenantid}"
    #  use_azuread_auth     = true
  }
}
 EOF
  filename = "${path.module}/templates/${local.upntrimmed}/backend.tf"
}


resource "local_file" "tf_providers" {
  content  = <<-EOF
terraform {
  ## before BSL license from Terraform
  ## compatible with OpenTofu 
  # required_version = "<= 1.5.4"

  ## after BSL license from Terraform
  required_version = ">= 1.6.0"
}
terraform {
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
  }
}
provider "azurerm" {
  storage_use_azuread = true
  subscription_id     = "${local.subscriptionid}"
  tenant_id           = "${local.tenantid}"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azuread" {
  tenant_id = "${local.tenantid}"
}


  EOF
  filename = "${path.module}/templates/${local.upntrimmed}/init.tf"
}

resource "local_file" "locals" {
  content  = <<-EOF
locals {
  environment = "poc"
  location    = "westeurope"
  tags = {
    location    = local.location
    deployed-by = "${data.azuread_user.current_user.user_principal_name}"
    owner       = "${data.azuread_user.current_user.user_principal_name}"
    managed     = "Terraform"
    git         = "https://github.com/topicusonderwijs/eduarte-alles-mag-dinsdag/terraform/backendgenerator"
  }
}
  EOF
  filename = "${path.module}/templates/${local.upntrimmed}/locals.tf"
}
