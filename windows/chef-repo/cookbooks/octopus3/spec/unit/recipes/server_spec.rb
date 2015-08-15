#
# Cookbook Name:: octopus3
# Spec:: server
#
# Copyright (c) 2015 Shaw Innes, All Rights Reserved.

require 'spec_helper'

describe 'octopus3::server' do
  context 'when on an `windows` platform, `2012r2` version' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'windows', version: '2012R2')
      runner.converge(described_recipe)
    end

    before do
      stub_command("    Test-Path \"C:\\Octopus/OctopusServer.config\"\n").and_return(false)
    end

    it 'extracts the `Octopus Tools` zip file' do
      expect(chef_run).to unzip_windows_zipfile_to('C:\\Octopus\\Tools')
    end

    it 'installs the `Octopus Deploy Server` package' do
      expect(chef_run).to install_windows_package('Octopus Deploy Server').with(installer_type: :msi)
    end

    it 'create web firewall rule' do
      expect(chef_run).to create_windows_firewall_rule('Octopus Admin')
                            .with(
                              localport: '80',
                              protocol: 'TCP',
                              dir: :in,
                              firewall_action: :allow)
    end

    it 'create octopus service firewall rule' do
      expect(chef_run).to create_windows_firewall_rule('Octopus Server')
                            .with(
                              localport: '10934',
                              protocol: 'TCP',
                              dir: :in,
                              firewall_action: :allow)
    end

    context 'and OctopusServer.config does not exist' do
      before do
        stub_command("    Test-Path \"C:\\Octopus/OctopusServer.config\"\n").and_return(false)
      end

      it 'execute powershell to create instance' do
         expect(chef_run).to run_powershell_script('Create Server Instance')
      end
    end

    context 'and OctopusServer.config does exists' do
      before do
        stub_command("    Test-Path \"C:\\Octopus/OctopusServer.config\"\n").and_return(true)
      end

      it 'does not execute powershell to create instance' do
         expect(chef_run).to_not run_powershell_script('Create Server Instance')
      end
    end

    it 'execute powershell step `Configure Server Instance`' do
      expect(chef_run).to run_powershell_script('Configure Server Instance')
    end

    it 'execute powershell step `Create Database`' do
      expect(chef_run).to run_powershell_script('Create Database')
    end

    it 'execute powershell step `Stop Service`' do
      expect(chef_run).to run_powershell_script('Stop Service')
    end

    it 'execute powershell step `Configure Administrator`' do
      expect(chef_run).to run_powershell_script('Configure Administrator')
    end

    it 'execute powershell step `Reconfigure and Start Service`' do
      expect(chef_run).to run_powershell_script('Reconfigure and Start Service')
    end

    context 'and licenseBase64 is set' do
      before do
        chef_run.node.set['octopus']['server']['base64license'] = 'base64'
        chef_run.converge(described_recipe)
      end

      it 'configures the license file' do
        expect(chef_run).to run_powershell_script('Configure License File')
      end

      it 'does not configure the free license' do
        expect(chef_run).to_not run_powershell_script('Configure Free License')
      end
    end

    context 'and licenseBase64 is not set' do
      before do
        chef_run.node.set['octopus']['server']['base64license'] = nil
        chef_run.converge(described_recipe)
      end

      it 'does not configure the license file' do
        expect(chef_run).to_not run_powershell_script('Configure License File')
      end

      it 'configures the free license' do
        expect(chef_run).to run_powershell_script('Configure Free License')
      end
    end

  end
end
