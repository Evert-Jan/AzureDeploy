#!/bin/bash
//test
set -x
source ./az-deploy.values
VirtualNetworkName=$(az network vnet list --query [].name --output tsv)
az network private-dns link vnet create \
    --zone-name ${privatednsname} \
    --name jisti-servers\
    --registration-enabled true \
    --resource-group ${resourcegroupname} \
    --subscription ${subscriptionID} \
    --tags ${tagskey1}=${tagvalue1} \
    --virtual-network ${VirtualNetworkName} 


