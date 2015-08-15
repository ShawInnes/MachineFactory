#
# Cookbook Name:: role-sqlserver
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'role-sqlserver::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'raises an error' do
      expect {
        chef_run
      }.to raise_error(RuntimeError)
    end
  end

  context 'When sqlserver source is set' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['sqlserver']['source'] = 'http://127.0.0.1'
        node.set['sqlserver']['edition'] = 'developer'
      end.converge(described_recipe)
    end

    it 'creates cached download file' do
       expect(chef_run).to create_remote_file(File.join(Chef::Config[:file_cache_path], 'en_sql_server_2014_developer_edition_x64_dvd_3940406.iso'))
    end

    it 'creates cached configuration file' do
       expect(chef_run).to render_file(File.join(Chef::Config[:file_cache_path], 'ConfigurationFile.ini'))
    end

    it 'execute powershell installation script' do
       expect(chef_run).to run_powershell_script('Install Microsoft SQL Server 2014 (64-bit)')
    end

    it 'create firewall rule' do
      expect(chef_run).to create_windows_firewall_rule('SQL Server')
                            .with(
                              localport: '1433',
                              protocol: 'TCP',
                              dir: :in,
                              firewall_action: :allow)
    end
  end
end
