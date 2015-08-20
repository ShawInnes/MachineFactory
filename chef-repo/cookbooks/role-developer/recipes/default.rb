#
# Cookbook Name:: role-octopusserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

## Install Visual Studio
include_recipe 'visualstudio::default'
include_recipe 'chocolatey'

%w(
  IIS-WebServerRole
  IIS-WebServerManagementTools
  IIS-ManagementConsole).each do |feat|
  windows_feature feat do
    action :install
  end
end

%w(
  NetFx3
  IIS-AspNet45
  IIS-WebServer).each do |feat|
  windows_feature feat do
    action :install
    all true
  end
end

iis_site 'Default Web Site' do
  action [:stop, :delete]
end

%w(
  wget
  git.install
  resharper-platform
  linqpad).each do |pkg|
  chocolatey pkg do
    action :install
  end
end

windows_package 'JetBrains Products in Visual Studio 2015' do
  source "#{ENV['programdata']}\\chocolatey\\lib\\resharper-platform\\ReSharperAndToolsPacked01Update1.exe"
  installer_type :custom
  options '/SpecificProductNames=ReSharper;dotTrace;dotCover;dotMemory;dotPeek;ReSharperPlatformVs14 /VsVersion=0;14 /Silent=True'
  timeout 600
end
