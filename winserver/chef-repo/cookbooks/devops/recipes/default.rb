#
# Cookbook Name:: devops
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

windows_feature "IIS-WebServerRole" do
  action :install
end

windows_feature "IIS-WebServerManagementTools" do
  action :install
end

windows_feature "IIS-ManagementConsole" do
  action :install
end

windows_feature "IIS-AspNet45" do
  action :install
  all true
end

windows_feature "IIS-WebServer" do
  action :install
  all true
end

windows_feature "NetFx3" do
  action :install
  all true
end

iis_site 'Default Web Site' do
  action [:stop, :delete]
end

%w{wget notepadplusplus}.each do |pkg|
  chocolatey pkg
end

windows_firewall_rule 'Octopus' do
  localport '10933'
  protocol 'TCP'
  dir :in
  firewall_action :allow
end
