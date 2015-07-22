## Install Chocolatey
$webClient=new-object net.webclient
$webClient.proxy.credentials=[system.net.credentialcache]::defaultnetworkcredentials
$webClient.downloadstring('https://chocolatey.org/install.ps1')|iex

choco feature enable -n=allowGlobalConfirmation

## this will most likely require a reboot, but it can be deferred until the end
choco upgrade powershell --pre


## Install Vagrant, Packer and Chef
choco install vagrant
choco install packer
choco install chefdk

