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

iis_site 'Default Web Site' do
  action [:stop, :delete]
end

