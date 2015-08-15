#
# Cookbook Name:: octopus3
# Recipe:: tentacle
#
# Copyright (c) 2015 Shaw Innes, All Rights Reserved.

windows_package node['octopus']['tentacle']['package_name'] do
  source node['octopus']['tentacle']['url']
  checksum node['octopus']['tentacle']['checksum']
  installer_type :msi
  action :install
end

windows_firewall_rule 'Octopus Tentacle' do
  localport node['octopus']['tentacle']['listen_port']
  protocol 'TCP'
  dir :in
  firewall_action :allow
end

tentacle_exe = File.join(node['octopus']['tentacle']['install_dir'], 'Tentacle.exe')
tentacle_config = File.join(node['octopus']['tentacle']['home'], 'Tentacle.config')

powershell_script 'Create Tentacle Instance' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{tentacle_exe}" create-instance --console --instance \"#{ node['octopus']['tentacle']['name'] }\" --config \"#{ tentacle_config }\"
  EOH
  not_if <<-EOH
    Test-Path "#{tentacle_config}"
  EOH
end

=begin
dsc_script 'install tentacle' do
  imports 'cTentacleAgent'
  code <<-EOH
    cTentacleAgent OctopusTentacle
    {
        Ensure = "Present";
        State = "Started";

        Name = "#{node['octopus']['tentacle']['name']}";

        # Registration - all parameters required
        ApiKey = "#{node['octopus']['api']['key']}";
        OctopusServerUrl = "#{node['octopus']['server']['url']}";
        Environments = @("#{node['octopus']['tentacle']['environment']}");
        Roles = @("#{node['octopus']['tentacle']['role']}");

        # Optional settings
        ListenPort = #{node['octopus']['server']['listen_port']};
        DefaultApplicationDirectory = "#{node['octopus']['tentacle']['applications']}"
    }
  EOH
end
=end

powershell_script 'Configure Certificate' do
  guard_interpreter :powershell_script
  flags '-NoLogo, -NonInteractive, -ExecutionPolicy RemoteSigned, -InputFormat None, -File'
  code <<-EOH
    & "#{tentacle_exe}" new-certificate --console `
                --instance \"#{node['octopus']['tentacle']['name']}\" `
                --if-blank
  EOH
  returns [0]
end

powershell_script 'Reset Trust' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{tentacle_exe}" configure --console `
                --instance "#{node['octopus']['tentacle']['name']}" `
                --reset-trust
  EOH
  returns [0, 100]
end

powershell_script 'Configure Tentacle' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{tentacle_exe}" configure --console `
                --instance "#{node['octopus']['tentacle']['name']}" `
                --home "#{node['octopus']['tentacle']['home']}" `
                --app "#{node['octopus']['tentacle']['applications']}" `
                --port "#{node['octopus']['tentacle']['listen_port']}" `
                --noListen "False"
  EOH
  returns [0, 100]
end

powershell_script 'Establish Trust' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{tentacle_exe}" configure --console `
                --instance "#{node['octopus']['tentacle']['name']}" `
                --trust "#{node['octopus']['server']['thumbprint']}"
  EOH
  returns [0, 100]
end

powershell_script 'Install and Start Service' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{tentacle_exe}" service --console `
                --instance "#{node['octopus']['tentacle']['name']}" `
                --install `
                --start
  EOH
  returns [0, 100]
end

powershell_script 'Register with Octopus Server' do
  guard_interpreter :powershell_script
  code <<-EOH
    & "#{tentacle_exe}" register-with --console `
                --instance "#{node['octopus']['tentacle']['name']}" `
                --server "#{node['octopus']['server']['url']}" `
                --name "#{node['hostname']}" `
                --publicHostName "#{node['ipaddress']}" `
                --apiKey "#{node['octopus']['api']['key']}" `
                --server-comms-port "#{node['octopus']['server']['listen_port']}" `
                --force `
                --environment "#{node['octopus']['tentacle']['environment']}" `
                --role "#{node['octopus']['tentacle']['role']}"
  EOH
  returns [0, 100]
end
