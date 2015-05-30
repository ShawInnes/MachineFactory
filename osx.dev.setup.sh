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

