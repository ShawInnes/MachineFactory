#!/bin/sh

VMVER="20150725.2"
VMNAME="server2012r2_$VMVER"

TEMPLATE=`knife vsphere template list --folder "templates"`

if echo $TEMPLATE | grep -q "$VMNAME"; then
  echo Template "$VMNAME" Already Exists

  exit 1
fi

VM=`knife vsphere vm list --folder "templates"`

if echo $VM | grep -q "$VMNAME"; then
  echo Virtual Machine "$VMNAME" Already Exists

  knife vsphere vm markastemplate "$VMNAME" --folder "templates"

  exit 0
fi

packer build -debug -var "vmname=$VMNAME" server2012r2.json 

