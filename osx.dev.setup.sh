#!/bin/sh

# export http_proxy=http://proxy:3128

## Install HomeBrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install caskroom/cask/brew-cask

brew cask install vagrant
vagrant plugin install vagrant-vmware-fusion
vagrant plugin install vagrant-winrm
vagrant plugin install vagrant-azure
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-secret
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-berkshelf
vagrant plugin install vagrant-proxyconf

brew cask install packer
brew install https://raw.githubusercontent.com/packer-community/packer-windows-plugins-brew/master/packer-windows-plugins.rb

brew cask install chefdk

# wget -c http://packages.vmware.com/tools/esx/5.5latest/windows/x64/VMware-tools-9.4.12-2627939-x86_64.exe -O packer/tools/VMware-tools-9.4.12-2627939-x86_64.exe
# wget -c https://opscode-omnibus-packages.s3.amazonaws.com/windows/2008r2/x86_64/chef-windows-11.18.6-1.windows.msi -O packer/tools/chef-windows-11.18.6-1.windows.msi
# wget -c http://download.jetbrains.com/teamcity/TeamCity-9.0.4.tar.gz -O teamcity/TeamCity-9.0.4.tar.gz
