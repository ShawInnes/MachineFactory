#
# Cookbook Name:: role-octopusserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

%w(octopusdeploy octopustools).each do |pkg|
  chocolatey pkg
end
