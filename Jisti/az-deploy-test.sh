#!/bin/bash
set -x
source ./az-deploy.values
zoneName=(az network vnet list --query [].name --output tsv)
az network private-dns link vnet create \
    --name jisti-servers\
    --registration-enabled true \
    --resource-group ${resourcegroupname} \
    --virtual-network ${zoneID}\ 
    --zone-name ${privatednsname} \
    --subscription ${subscriptionID} \
    --tags ${tagskey1}=${tagvalue1} 


