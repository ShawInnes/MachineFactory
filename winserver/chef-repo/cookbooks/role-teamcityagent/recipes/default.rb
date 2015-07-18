#
# Cookbook Name:: role-teamcityagent
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{jre8}.each do |pkg|
  chocolatey pkg
end