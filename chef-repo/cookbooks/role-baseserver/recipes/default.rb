#
# Cookbook Name:: role-baseserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

windows_firewall_rule 'Octopus Deploy' do
  localport '10933'
  protocol 'TCP'
  dir :in
  firewall_action :allow
  #  action :create
end
