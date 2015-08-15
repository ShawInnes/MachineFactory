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

    before do
      stub_command("    Test-Path \"C:\\Octopus/Tentacle.config\"\n").and_return(false)
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

    context 'and Tentacle.config does not exist' do
      before do
        stub_command("    Test-Path \"C:\\Octopus/Tentacle.config\"\n").and_return(false)
      end

      it 'execute powershell to create instance' do
         expect(chef_run).to run_powershell_script('Create Tentacle Instance')
      end
    end

    context 'and Tentacle.config does exists' do
      before do
        stub_command("    Test-Path \"C:\\Octopus/Tentacle.config\"\n").and_return(true)
      end

      it 'does not execute powershell to create instance' do
         expect(chef_run).to_not run_powershell_script('Create Tentacle Instance')
      end
    end

    it 'execute powershell step `Configure Certificate`' do
      expect(chef_run).to run_powershell_script('Configure Certificate')
    end

    it 'execute powershell step `Reset Trust`' do
      expect(chef_run).to run_powershell_script('Reset Trust')
    end

    it 'execute powershell step `Configure Tentacle`' do
      expect(chef_run).to run_powershell_script('Configure Tentacle')
    end

    it 'execute powershell step `Establish Trust`' do
      expect(chef_run).to run_powershell_script('Establish Trust')
    end

    it 'execute powershell step `Install and Start Service`' do
      expect(chef_run).to run_powershell_script('Install and Start Service')
    end

    it 'execute powershell step `Register with Octopus Server`' do
      expect(chef_run).to run_powershell_script('Register with Octopus Server')
    end
  end
end
