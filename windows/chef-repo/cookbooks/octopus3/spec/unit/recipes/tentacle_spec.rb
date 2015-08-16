#
# Cookbook Name:: octopus3
# Spec:: tentacle
#
# Copyright (c) 2015 Shaw Innes, All Rights Reserved.

require 'spec_helper'

describe 'octopus3::tentacle' do
  context 'when on an `windows` platform, `2012r2` version' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'windows', version: '2012R2')
      runner.converge(described_recipe)
    end

    it 'installs the `Octopus Deploy Tentacle` package' do
      expect(chef_run).to install_windows_package('Octopus Deploy Tentacle').with(installer_type: :msi)
    end

    it 'create tentacle firewall rule' do
      expect(chef_run).to create_windows_firewall_rule('Octopus Tentacle')
                            .with(
                              localport: '10933',
                              protocol: 'TCP',
                              dir: :in,
                              firewall_action: :allow)
    end
  end
end
