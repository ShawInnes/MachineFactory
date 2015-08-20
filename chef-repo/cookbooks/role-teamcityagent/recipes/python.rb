#
# Cookbook Name:: role-teamcityagent
# Recipe:: python

include_recipe 'windows'

windows_package node['python']['package_name'] do
  source node['python']['url']
  installer_type :msi
  options '/qn /norestart ALLUSERS=1'
end
