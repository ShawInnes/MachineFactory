#
# Cookbook Name:: role-baseserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

%w[ /LokiDir/data /LokiDir/bin /TattsDir/data /TattsDir/bin /TaGsDir/data /TaGsDir/bin ].each do |path|
  directory path do
    recursive true
    :create
  end
end

