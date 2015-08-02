#!/bin/sh

EDITION="2012r2"
VMVER="20150729.$EDITION.2"
VMNAME="server$EDITION_$VMVER"

PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool"

packer build -var "vmname=$VMNAME" -var "edition=$EDITION" server2012r2.json

