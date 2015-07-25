#
# Cookbook Name:: role-octopusserver
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

chocolatey "PowerShell" do
  version "5.0.10105-April2015Preview"
  action :upgrade
end

chocolatey "wget" do
  action :install
end

chocolatey "git.install" do
  action :upgrade
end

