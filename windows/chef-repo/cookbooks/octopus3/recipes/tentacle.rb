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

remote_directory "#{ENV['PROGRAMW6432']}\\WindowsPowerShell\\Modules\\OctopusDSC" do
  source 'OctopusDSC'
  action :create
end

dsc_script 'OctopusTentacle' do
  imports 'OctopusDSC'

  code <<-EOH
    #Import-DscResource -ModuleName OctopusDSC

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
        IPAddress = "#{node['ipaddress']}";

        # Optional settings
        ListenPort = #{node['octopus']['server']['listen_port']};
        DefaultApplicationDirectory = "#{node['octopus']['tentacle']['applications']}"
    }
  EOH
end
