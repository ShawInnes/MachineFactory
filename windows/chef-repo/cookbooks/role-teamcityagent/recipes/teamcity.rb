#
# Cookbook Name:: role-teamcityagent
# Recipe:: teamcity

include_recipe 'windows'
include_recipe 'java::default'

include_recipe 'chef-teamcity::windows_agent'

windows_firewall_rule 'TeamCity Agent' do
  localport '9090'
  protocol 'TCP'
  dir :in
  firewall_action :allow
end

windows_registry 'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings' do
  values 'ProxyEnable' => 0
end

directory node['teamcity']['agent']['work_dir'] do
  :create
  rights :full_control, 'Everyone', applies_to_children: true
end

powershell_script 'Share Work Folder' do
  code <<-EOH
    New-SmbShare -Name "Work" -Path "#{node['teamcity']['agent']['work_dir']}"
  EOH
  guard_interpreter :powershell_script
  not_if <<-EOH
    (Get-SmbShare -Name "Work").Name -eq "Work"
  EOH
end
