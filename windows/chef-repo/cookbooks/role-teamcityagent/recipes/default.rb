#
# Cookbook Name:: role-teamcityagent
# Recipe:: default

include_recipe 'role-teamcityagent::visualstudio'

include_recipe 'role-teamcityagent::nodejs'

include_recipe 'role-teamcityagent::teamcity'
