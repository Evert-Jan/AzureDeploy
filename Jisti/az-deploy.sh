#!/bin/bash
set -x
source ./az-deploy.values

az account list --output table
az account set &{subscriptionID}
az group create &{resourcegroupname} --subscription &{subscriptionID}
az vnet create  &{vnetname} --subscription &{subscriptionID}