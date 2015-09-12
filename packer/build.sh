#!/bin/sh

BASENAME="W2012R2_RTM_Standard_VL"
EDITION="2012r2"
VMVER=`date "+%Y%m%d-%H%M"`
VMNAME="$BASENAME_$EDITION_$VMVER"

echo $VMNAME

PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool"


## PACKER_LOG=1

## You will need to run this on the esxi host first
## esxcli system settings advanced set -o /Net/GuestIPHack -i 1
=======
packer build -var "vmname=$VMNAME" -var "edition=$EDITION" packer.json
