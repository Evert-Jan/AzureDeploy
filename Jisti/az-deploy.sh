#!/bin/bash
set -x
source ./values

az account list --output table
az account set &{subscriptionID}
az group create &{resourcegroupname}
az vnet create 