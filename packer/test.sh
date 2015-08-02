#!/bin/sh

## this will do a manual winrm test (-m) and execute a command (dir)

knife winrm 172.16.10.145 dir -m -P packer -x packer -z
