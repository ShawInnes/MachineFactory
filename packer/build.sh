#!/bin/sh

EDITION="2012r2core"
VMVER="20150729.$EDITION.1"
VMNAME="server$EDITION_$VMVER"

PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool"

#TEMPLATE=`knife vsphere template list --folder "templates"`

#if echo $TEMPLATE | grep -q "$VMNAME"; then
#  echo Template "$VMNAME" Already Exists
#
#  exit 1
#fi

#VM=`knife vsphere vm list --folder "templates"`

#if echo $VM | grep -q "$VMNAME"; then
#  echo Virtual Machine "$VMNAME" Already Exists
#
#  knife vsphere vm markastemplate "$VMNAME" --folder "templates" --config ./knife.rb
#
#  exit 0
#fi

packer build -var "vmname=$VMNAME" -var "edition=$EDITION" server2012r2.json 

