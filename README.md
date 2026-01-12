# AzureDeploy
Templates for Azure Deployments

## Backend generator
    Creates:    - resourcegroup with {$UPN}-state-rg.
                - storage accout {first_10_charaters_ofyour_$UPN}{5_random_numbers}.
                - blob with name "tfstate".
                - template files for future terraform code that uses the storage account to save your state in "./templates/{$UPN}.
