#!/bin/sh

VMNAME="server01"
ENVIRONMENT="development"

TEMPLATEVER="20150725.2"
TEMPLATENAME="server2012r2_$TEMPLATEVER"

VM=`knife vsphere vm list --folder "templates"`

if echo $VM | grep -q "$VMNAME"; then
  echo Virtual Machine "$VMNAME" Already Exists

  exit 1
fi

knife vsphere vm clone $VMNAME \
	--template "$TEMPLATENAME" \
	--folder "templates" \
	--dest-folder "$ENVIRONMENT" \
	--cspec "default" \
	--start 
	# --bootstrap \
	# --winrm-user packer \
	# --winrm-password packer

