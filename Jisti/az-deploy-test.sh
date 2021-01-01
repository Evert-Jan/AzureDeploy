#!/bin/bash
set -x
source ./az-deploy.values

az network private-dns link vnet create \
    --name jisti-servers\
    --registration-enabled true \
    --resource-group ${resourcegroupname} \
    --virtual-network $(az network vnet list --query [].id --output tsv)\ 
    --zone-name ${privatednsname} \
    --subscription ${subscriptionID} \
    --tags ${tagskey1}=${tagvalue1} 


