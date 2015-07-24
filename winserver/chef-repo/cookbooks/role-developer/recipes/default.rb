#
# Cookbook Name:: role-octopusserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

mount "I:" do
  action :mount
  device "\\\\vmware-host\\Shared Folders"
end

