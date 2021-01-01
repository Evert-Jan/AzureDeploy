#!/bin/bash
set -x
source ./az-deploy.values

az account list --output table

az account set \
    --subscription ${subscriptionID}

az group create \
    --name ${resourcegroupname} \
    --subscription ${subscriptionID} \
    --location ${azurelocation} 

az network vnet create  \
    --name ${vnetname} \
    --subscription ${subscriptionID} \
    --address-prefixes 172.16.0.0/16 \
    --location ${azurelocation} \
    --subnet-name ${subnetname} \
    --subnet-prefixes 172.16.10.0/24 \
    --tags ${tagskey1}=${tagvalue1} \
    --resource-group ${resourcegroupname} 

az network private-dns zone create \
    --name ${privatednsname} \
    --resource-group ${resourcegroupname} \
    --tags ${tagskey1}=${tagvalue1} 


az network watcher configure \
    --subscription ${subscriptionID} \
    --resource-group ${resourcegroupname} \
    --location ${azurelocation} \
    --enable true

az network private-dns link vnet create \
    --name jisti-servers\
    --registration-enabled true \
    --resource-group ${resourcegroupname} \
    --virtual-network ${zone-id=az network vnet list --query [].id --output tsv}\ 
    --zone-name ${privatednsname} \
    --subscription ${subscriptionID} \
    --tags ${tagskey1}=${tagvalue1} 



    