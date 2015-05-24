

## Install Chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

## Install Vagrant, Packer and Chef
choco install vagrant
choco install packer
choco install chefdk

