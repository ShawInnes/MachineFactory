#
# Cookbook Name:: role-teamcityagent
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nodejs-windows::default'

%w{jre8}.each do |pkg|
  chocolatey pkg
end

