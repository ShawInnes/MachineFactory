#
# Cookbook Name:: role-teamcityagent
# Recipe:: default

cookbook_file "C:\\ProgramData\\gemrc" do
  source 'gemrc'
  action :create
end

include_recipe 'role-teamcityagent::visualstudio'

include_recipe 'role-teamcityagent::nodejs'

include_recipe 'role-teamcityagent::python'

include_recipe 'role-teamcityagent::teamcity'
