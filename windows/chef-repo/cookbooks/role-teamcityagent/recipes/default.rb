#
# Cookbook Name:: role-teamcityagent
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# include_recipe 'nodejs-windows::default'

include_recipe "chef-teamcity::windows_agent"
include_recipe 'nodejs-windows::default'
include_recipe 'visualstudio::default'

windows_firewall_rule 'TeamCity Agent' do
  localport '9090'
  protocol 'TCP'
  dir :in
  firewall_action :allow
end

directory node['teamcity']['agent']['work_dir'] do
  rights :full_control, 'Everyone', :applies_to_children => true
end

powershell_script "Share Work Folder" do
  guard_interpreter :powershell_script
  code <<-EOH
    New-SmbShare -Name "Work" -Path "#{node['teamcity']['agent']['work_dir']}"
  EOH
  not_if <<-EOH
    (Get-SmbShare -Name "Work").Name -eq "Work"
  EOH
end
