data "azurerm_client_config" "current" {}

data "azuread_user" "current_user" {
  user_principal_name =nonsensitive(replace(lower(module.shell_data_getupn.stdout), "\"", "") )
}

# output "azurerm_client_config" {
#   value = data.azurerm_client_config.current
# }


module "shell_data_getsubscription" {
  source = "Invicton-Labs/shell-data/external"

  // This is the command that will be run on Unix-based systems
  // If you wanted to, you could use the file() function to read 
  // this command from a local file instead of specifying it as
  // a string.
  command_unix = <<EOF
 az account show --query id
EOF
  working_dir = path.module
  fail_on_nonzero_exit_code = true
  fail_on_stderr = false
  force_wait_for_apply = false
}


module "shell_data_getupn" {
  source = "Invicton-Labs/shell-data/external"

  // This is the command that will be run on Unix-based systems
  // If you wanted to, you could use the file() function to read 
  // this command from a local file instead of specifying it as
  // a string.
  command_unix = <<EOF
az account show --query user.name
EOF
  working_dir = path.module
  fail_on_nonzero_exit_code = true
  fail_on_stderr = false
  force_wait_for_apply = false
}

# output "stdout" {
#   value     = nonsensitive(module.shell_data_hello.stdout)
#   # sensitive = true
# }
# output "stderr" {
#   value     = module.shell_data_hello.stderr
#   sensitive = true
# }
# output "exit_code" {
#   value     = module.shell_data_hello.exit_code
#   sensitive = true
# }

# output "upn" {
#  value = nonsensitive(replace(lower(module.shell_data_hello.stdout), "\"", "") )
# }
 