#
# Cookbook Name:: role-teamcityagent
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# include_recipe 'nodejs-windows::default'
# include_recipe 'nodejs-windows::default'

include_recipe "chef-teamcity::windows_agent"

windows_firewall_rule 'TeamCity Agent' do
  localport '9090'
  protocol 'TCP'
  dir :in
  firewall_action :allow
end
