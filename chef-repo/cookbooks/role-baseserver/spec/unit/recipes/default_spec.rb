#
# Cookbook Name:: role-baseserver
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'role-baseserver::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'installs `Octopus Deploy` allow firewall rule' do
      expect(chef_run).to create_windows_firewall_rule('Octopus Deploy')

      expect(chef_run).to create_windows_firewall_rule('Octopus Deploy')
        .with(
              localport: '10933',
              protocol: 'TCP',
              dir: :in,
              firewall_action: :allow)
    end
  end
end
