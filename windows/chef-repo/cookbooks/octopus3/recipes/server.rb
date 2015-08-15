#
# Cookbook Name:: octopus3
# Recipe:: server
#
# Copyright (c) 2015 Shaw Innes, All Rights Reserved.

windows_zipfile node['octopus']['tools']['install_dir'] do
  source node['octopus']['tools']['url']
  checksum node['octopus']['tools']['checksum']
  action :unzip
  not_if {::Dir.exist?(node['octopus']['tools']['install_dir'])}
end

windows_package node['octopus']['server']['package_name'] do
  source node['octopus']['server']['url']
  checksum node['octopus']['server']['checksum']
  installer_type :msi
  action :install
end

windows_firewall_rule 'Octopus Admin' do
  localport node['octopus']['server']['web_port']
  protocol 'TCP'
  dir :in
  firewall_action :allow
end

windows_firewall_rule 'Octopus Server' do
  localport node['octopus']['server']['listen_port']
  protocol 'TCP'
  dir :in
  firewall_action :allow
end

octopus_exe = File.join(node['octopus']['server']['install_dir'], 'Octopus.Server.exe')
octopus_config = File.join(node['octopus']['server']['home'], 'OctopusServer.config')

powershell_script 'Create Server Instance' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{octopus_exe}" create-instance --console --instance "#{ node['octopus']['server']['name'] }" --config "#{ octopus_config }"
  EOH
  not_if <<-EOH
    Test-Path "#{octopus_config}"
  EOH
end

powershell_script 'Configure Server Instance' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{octopus_exe}" configure --console `
                --instance "#{node['octopus']['server']['name']}" `
                --home "#{node['octopus']['server']['home']}" `
                --storageConnectionString "#{node['octopus']['server']['connectionstring']}" `
                --webAuthenticationMode "#{node['octopus']['server']['authentication_mode']}" `
                --webForceSSL "False" `
                --webListenPrefixes "http://localhost:#{node['octopus']['server']['web_port']}/" `
                --commsListenPort "#{node['octopus']['server']['listen_port']}" `
                --upgradeCheck "False" `
                --upgradeCheckWithStatistics "False" `
                --serverNodeName #{node['hostname']}
  EOH
end

powershell_script 'Create Database' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{octopus_exe}" database --console `
                --instance "#{node['octopus']['server']['name']}" `
                --create
  EOH
  returns [0, 100]
end

powershell_script 'Stop Service' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{octopus_exe}" service --console `
                --instance "#{node['octopus']['server']['name']}" `
                --stop
  EOH
  returns [0, 100]
end

powershell_script 'Configure Administrator' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{octopus_exe}" admin --console `
                --instance "#{node['octopus']['server']['name']}" `
                --username "#{node['octopus']['server']['admin_user']}" `
                --password "#{node['octopus']['server']['admin_password']}"
  EOH
  returns [0, 100]
end

powershell_script 'Configure License File' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{octopus_exe}" license --console `
                --instance "#{node['octopus']['server']['name']}" `
                --licenseBase64 "#{node['octopus']['server']['base64license']}"
  EOH
  only_if { node['octopus']['server']['base64license'] }
  returns [0, 100]
end

powershell_script 'Configure Free License' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{octopus_exe}" license --console `
                --instance "#{node['octopus']['server']['name']}" `
                --free
  EOH
  not_if { node['octopus']['server']['base64license'] }
  returns [0, 100]
end

powershell_script 'Reconfigure and Start Service' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{octopus_exe}" service --console `
                --instance "#{node['octopus']['server']['name']}" `
                --install `
                --reconfigure `
                --start `
                --username "#{node['octopus']['server']['service_user']}" `
                --password "#{node['octopus']['server']['service_password']}" `
  EOH
  returns [0, 100]
end
