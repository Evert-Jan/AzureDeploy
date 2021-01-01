#!/bin/bash
set -x
source ./az-deploy.values
VirtualNetworkName=$(az network vnet list --query [].name --output tsv)
az network private-dns link vnet create \
    --name jisti-servers\
    --registration-enabled true \
    --resource-group ${resourcegroupname} \
    --zone-name ${privatednsname} \
    --subscription ${subscriptionID} \
    --tags ${tagskey1}=${tagvalue1} \
    --virtual-network ${VirtualNetworkName} 


