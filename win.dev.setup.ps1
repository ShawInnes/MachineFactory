## Install WMF5 or Use Windows 10

## choco feature enable -n=allowGlobalConfirmation

Set-ExecutionPolicy RemoteSigned
Get-PackageProvider -name Chocolatey -ForceBootstrap

Unregister-PackageSource -Name Chocolatey
Register-PackageSource -Name Chocolatey -ProviderName Chocolatey -Trusted -Location http://chocolatey.org/api/v2/

## Install Common Utilities
Install-Package git.install
Install-Package notepadplusplus

## Install Vagrant, Packer, Terraform
Install-Package vagrant
Install-Package packer
Install-Package terraform

## Install Chef Development Kit
Install-Package chefdk
