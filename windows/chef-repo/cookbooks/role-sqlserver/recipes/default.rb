#
# Cookbook Name:: role-sqlserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

if !node['sqlserver']['source']
  raise 'SQL Server source attribute must be set before running this cookbook'
end

version = 'sql' + node['sqlserver']['version']
edition = node['sqlserver']['edition']

iso_url = File.join(node['sqlserver']['source'], node['sqlserver'][edition]['filename'])
iso_path = File.join(Chef::Config[:file_cache_path], node['sqlserver'][edition]['filename'])

config_file_path = File.join(Chef::Config[:file_cache_path], 'ConfigurationFile.ini')

remote_file iso_path do
  source iso_url
  checksum node['sqlserver'][edition]['checksum']
  not_if { File.exists?(iso_path)}
end

template config_file_path do
  source 'ConfigurationFile.ini.erb'
end

#reboot 'Restart Computer' do
#  action :nothing
#end

powershell_script "Install #{node['sqlserver'][edition]['package_name']}" do
  code <<-EOH
    $ImagePath = "#{iso_path}"
    Mount-DiskImage -ImagePath $ImagePath
    $DriveLetter = (Get-DiskImage -ImagePath $ImagePath | Get-Volume).DriveLetter
    $Command = "${DriveLetter}:\\#{node['sqlserver'][edition]['installer_file']}"
    $ArgList = "/q /ConfigurationFile=#{config_file_path}"
    Start-Process -FilePath $Command -ArgumentList $ArgList -Wait
    Dismount-DiskImage -ImagePath $ImagePath
	Exit 0
  EOH
  returns [0, 1]
  guard_interpreter :powershell_script
  #notifies :reboot_now, 'reboot[Restart Computer]', :immediately
end
