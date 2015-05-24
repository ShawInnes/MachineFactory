#!/bin/sh

brew install caskroom/cask/brew-cask

brew cask install alfred
brew cask install vlc
brew cask install chefdk
brew cask install intellij-idea

brew cask install vagrant
vagrant plugin install vagrant-vmware-fusion
vagrant plugin install vagrant-dsc
vagrant plugin install vagrant-hostmanager

brew install nodejs
npm install azure-cli -g

brew cask install packer
brew install https://raw.githubusercontent.com/packer-community/packer-windows-plugins-brew/master/packer-windows-plugins.rb

