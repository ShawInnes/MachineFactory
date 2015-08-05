#!/bin/sh

BASENAME="W2012R2_RTM_Standard_VL"
EDITION="2012r2"
VMVER=`date "+%Y%m%d-%H%M"`
VMNAME="$BASENAME_$EDITION_$VMVER"

echo $VMNAME

PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool"

TEMPLATE=`knife vsphere template list --folder "templates" --config ./knife.rb`

if echo $TEMPLATE | grep -q "$VMNAME"; then
  echo Template "$VMNAME" Already Exists

  exit 1
fi

VM=`knife vsphere vm list --folder "templates"`

if echo $VM | grep -q "$VMNAME"; then
  echo Virtual Machine "$VMNAME" Already Exists

  knife vsphere vm markastemplate "$VMNAME" --folder "templates" --config ./knife.rb

  exit 0
fi

## PACKER_LOG=1 

## You will need to run this on the esxi host first
## esxcli system settings advanced set -o /Net/GuestIPHack -i 1

packer build -var "vmname=$VMNAME" -var "edition=$EDITION" server2012r2_vsphere.json

