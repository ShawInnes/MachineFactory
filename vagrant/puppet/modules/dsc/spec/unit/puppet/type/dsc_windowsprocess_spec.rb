#!/usr/bin/env ruby
require 'spec_helper'

describe Puppet::Type.type(:dsc_windowsprocess) do

  let :dsc_windowsprocess do
    Puppet::Type.type(:dsc_windowsprocess).new(
      :name     => 'foo',
      :dsc_path => 'foo',
      :dsc_arguments => 'foo',
    )
  end

  it "should stringify normally" do
    expect(dsc_windowsprocess.to_s).to eq("Dsc_windowsprocess[foo]")
  end

  it 'should default to ensure => present' do
    expect(dsc_windowsprocess[:ensure]).to eq :present
  end

  it 'should require that dsc_path is specified' do
    #dsc_windowsprocess[:dsc_path]
    expect { Puppet::Type.type(:dsc_windowsprocess).new(
      :name     => 'foo',
      :dsc_arguments => 'foo',
      :dsc_credential => 'foo',
      :dsc_ensure => 'Present',
      :dsc_standardoutputpath => 'foo',
      :dsc_standarderrorpath => 'foo',
      :dsc_standardinputpath => 'foo',
      :dsc_workingdirectory => 'foo',
      :dsc_pagedmemorysize => 64,
      :dsc_nonpagedmemorysize => 64,
      :dsc_virtualmemorysize => 64,
      :dsc_handlecount => -32,
      :dsc_processid => -32,
    )}.to raise_error(Puppet::Error, /dsc_path is a required attribute/)
  end

  it 'should not accept array for dsc_path' do
    expect{dsc_windowsprocess[:dsc_path] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_path' do
    expect{dsc_windowsprocess[:dsc_path] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_path' do
    expect{dsc_windowsprocess[:dsc_path] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_path' do
    expect{dsc_windowsprocess[:dsc_path] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should require that dsc_arguments is specified' do
    #dsc_windowsprocess[:dsc_arguments]
    expect { Puppet::Type.type(:dsc_windowsprocess).new(
      :name     => 'foo',
      :dsc_path => 'foo',
      :dsc_credential => 'foo',
      :dsc_ensure => 'Present',
      :dsc_standardoutputpath => 'foo',
      :dsc_standarderrorpath => 'foo',
      :dsc_standardinputpath => 'foo',
      :dsc_workingdirectory => 'foo',
      :dsc_pagedmemorysize => 64,
      :dsc_nonpagedmemorysize => 64,
      :dsc_virtualmemorysize => 64,
      :dsc_handlecount => -32,
      :dsc_processid => -32,
    )}.to raise_error(Puppet::Error, /dsc_arguments is a required attribute/)
  end

  it 'should not accept array for dsc_arguments' do
    expect{dsc_windowsprocess[:dsc_arguments] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_arguments' do
    expect{dsc_windowsprocess[:dsc_arguments] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_arguments' do
    expect{dsc_windowsprocess[:dsc_arguments] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_arguments' do
    expect{dsc_windowsprocess[:dsc_arguments] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_credential' do
    expect{dsc_windowsprocess[:dsc_credential] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_credential' do
    expect{dsc_windowsprocess[:dsc_credential] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_credential' do
    expect{dsc_windowsprocess[:dsc_credential] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_credential' do
    expect{dsc_windowsprocess[:dsc_credential] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept dsc_ensure predefined value Present' do
    dsc_windowsprocess[:dsc_ensure] = 'Present'
    expect(dsc_windowsprocess[:dsc_ensure]).to eq('Present')
  end

  it 'should accept dsc_ensure predefined value present' do
    dsc_windowsprocess[:dsc_ensure] = 'present'
    expect(dsc_windowsprocess[:dsc_ensure]).to eq('present')
  end

  it 'should accept dsc_ensure predefined value present and update ensure with this value (ensure end value should be a symbol)' do
    dsc_windowsprocess[:dsc_ensure] = 'present'
    expect(dsc_windowsprocess[:ensure]).to eq(dsc_windowsprocess[:dsc_ensure].downcase.to_sym)
  end

  it 'should accept dsc_ensure predefined value Absent' do
    dsc_windowsprocess[:dsc_ensure] = 'Absent'
    expect(dsc_windowsprocess[:dsc_ensure]).to eq('Absent')
  end

  it 'should accept dsc_ensure predefined value absent' do
    dsc_windowsprocess[:dsc_ensure] = 'absent'
    expect(dsc_windowsprocess[:dsc_ensure]).to eq('absent')
  end

  it 'should accept dsc_ensure predefined value absent and update ensure with this value (ensure end value should be a symbol)' do
    dsc_windowsprocess[:dsc_ensure] = 'absent'
    expect(dsc_windowsprocess[:ensure]).to eq(dsc_windowsprocess[:dsc_ensure].downcase.to_sym)
  end

  it 'should not accept values not equal to predefined values' do
    expect{dsc_windowsprocess[:dsc_ensure] = 'invalid value'}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_ensure' do
    expect{dsc_windowsprocess[:dsc_ensure] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_ensure' do
    expect{dsc_windowsprocess[:dsc_ensure] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_ensure' do
    expect{dsc_windowsprocess[:dsc_ensure] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_ensure' do
    expect{dsc_windowsprocess[:dsc_ensure] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_standardoutputpath' do
    expect{dsc_windowsprocess[:dsc_standardoutputpath] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_standardoutputpath' do
    expect{dsc_windowsprocess[:dsc_standardoutputpath] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_standardoutputpath' do
    expect{dsc_windowsprocess[:dsc_standardoutputpath] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_standardoutputpath' do
    expect{dsc_windowsprocess[:dsc_standardoutputpath] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_standarderrorpath' do
    expect{dsc_windowsprocess[:dsc_standarderrorpath] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_standarderrorpath' do
    expect{dsc_windowsprocess[:dsc_standarderrorpath] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_standarderrorpath' do
    expect{dsc_windowsprocess[:dsc_standarderrorpath] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_standarderrorpath' do
    expect{dsc_windowsprocess[:dsc_standarderrorpath] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_standardinputpath' do
    expect{dsc_windowsprocess[:dsc_standardinputpath] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_standardinputpath' do
    expect{dsc_windowsprocess[:dsc_standardinputpath] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_standardinputpath' do
    expect{dsc_windowsprocess[:dsc_standardinputpath] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_standardinputpath' do
    expect{dsc_windowsprocess[:dsc_standardinputpath] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_workingdirectory' do
    expect{dsc_windowsprocess[:dsc_workingdirectory] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_workingdirectory' do
    expect{dsc_windowsprocess[:dsc_workingdirectory] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_workingdirectory' do
    expect{dsc_windowsprocess[:dsc_workingdirectory] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_workingdirectory' do
    expect{dsc_windowsprocess[:dsc_workingdirectory] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_pagedmemorysize' do
    expect{dsc_windowsprocess[:dsc_pagedmemorysize] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_pagedmemorysize' do
    expect{dsc_windowsprocess[:dsc_pagedmemorysize] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_pagedmemorysize' do
    expect{dsc_windowsprocess[:dsc_pagedmemorysize] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept uint for dsc_pagedmemorysize' do
    dsc_windowsprocess[:dsc_pagedmemorysize] = 64
    expect(dsc_windowsprocess[:dsc_pagedmemorysize]).to eq(64)
  end


  it 'should accept string-like int for dsc_pagedmemorysize' do
    dsc_windowsprocess[:dsc_pagedmemorysize] = '16'
    expect(dsc_windowsprocess[:dsc_pagedmemorysize]).to eq(16)
  end


  it 'should accept string-like int for dsc_pagedmemorysize' do
    dsc_windowsprocess[:dsc_pagedmemorysize] = '32'
    expect(dsc_windowsprocess[:dsc_pagedmemorysize]).to eq(32)
  end


  it 'should accept string-like int for dsc_pagedmemorysize' do
    dsc_windowsprocess[:dsc_pagedmemorysize] = '64'
    expect(dsc_windowsprocess[:dsc_pagedmemorysize]).to eq(64)
  end

  it 'should not accept array for dsc_nonpagedmemorysize' do
    expect{dsc_windowsprocess[:dsc_nonpagedmemorysize] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_nonpagedmemorysize' do
    expect{dsc_windowsprocess[:dsc_nonpagedmemorysize] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_nonpagedmemorysize' do
    expect{dsc_windowsprocess[:dsc_nonpagedmemorysize] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept uint for dsc_nonpagedmemorysize' do
    dsc_windowsprocess[:dsc_nonpagedmemorysize] = 64
    expect(dsc_windowsprocess[:dsc_nonpagedmemorysize]).to eq(64)
  end


  it 'should accept string-like int for dsc_nonpagedmemorysize' do
    dsc_windowsprocess[:dsc_nonpagedmemorysize] = '16'
    expect(dsc_windowsprocess[:dsc_nonpagedmemorysize]).to eq(16)
  end


  it 'should accept string-like int for dsc_nonpagedmemorysize' do
    dsc_windowsprocess[:dsc_nonpagedmemorysize] = '32'
    expect(dsc_windowsprocess[:dsc_nonpagedmemorysize]).to eq(32)
  end


  it 'should accept string-like int for dsc_nonpagedmemorysize' do
    dsc_windowsprocess[:dsc_nonpagedmemorysize] = '64'
    expect(dsc_windowsprocess[:dsc_nonpagedmemorysize]).to eq(64)
  end

  it 'should not accept array for dsc_virtualmemorysize' do
    expect{dsc_windowsprocess[:dsc_virtualmemorysize] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_virtualmemorysize' do
    expect{dsc_windowsprocess[:dsc_virtualmemorysize] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_virtualmemorysize' do
    expect{dsc_windowsprocess[:dsc_virtualmemorysize] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept uint for dsc_virtualmemorysize' do
    dsc_windowsprocess[:dsc_virtualmemorysize] = 64
    expect(dsc_windowsprocess[:dsc_virtualmemorysize]).to eq(64)
  end


  it 'should accept string-like int for dsc_virtualmemorysize' do
    dsc_windowsprocess[:dsc_virtualmemorysize] = '16'
    expect(dsc_windowsprocess[:dsc_virtualmemorysize]).to eq(16)
  end


  it 'should accept string-like int for dsc_virtualmemorysize' do
    dsc_windowsprocess[:dsc_virtualmemorysize] = '32'
    expect(dsc_windowsprocess[:dsc_virtualmemorysize]).to eq(32)
  end


  it 'should accept string-like int for dsc_virtualmemorysize' do
    dsc_windowsprocess[:dsc_virtualmemorysize] = '64'
    expect(dsc_windowsprocess[:dsc_virtualmemorysize]).to eq(64)
  end

  it 'should not accept array for dsc_handlecount' do
    expect{dsc_windowsprocess[:dsc_handlecount] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_handlecount' do
    expect{dsc_windowsprocess[:dsc_handlecount] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept int for dsc_handlecount' do
    dsc_windowsprocess[:dsc_handlecount] = -32
    expect(dsc_windowsprocess[:dsc_handlecount]).to eq(-32)
  end


  it 'should accept string-like int for dsc_handlecount' do
    dsc_windowsprocess[:dsc_handlecount] = '16'
    expect(dsc_windowsprocess[:dsc_handlecount]).to eq(16)
  end


  it 'should accept string-like int for dsc_handlecount' do
    dsc_windowsprocess[:dsc_handlecount] = '-16'
    expect(dsc_windowsprocess[:dsc_handlecount]).to eq(-16)
  end


  it 'should accept string-like int for dsc_handlecount' do
    dsc_windowsprocess[:dsc_handlecount] = '32'
    expect(dsc_windowsprocess[:dsc_handlecount]).to eq(32)
  end


  it 'should accept string-like int for dsc_handlecount' do
    dsc_windowsprocess[:dsc_handlecount] = '-32'
    expect(dsc_windowsprocess[:dsc_handlecount]).to eq(-32)
  end


  it 'should accept uint for dsc_handlecount' do
    dsc_windowsprocess[:dsc_handlecount] = -32
    expect(dsc_windowsprocess[:dsc_handlecount]).to eq(-32)
  end


  it 'should accept string-like int for dsc_handlecount' do
    dsc_windowsprocess[:dsc_handlecount] = '16'
    expect(dsc_windowsprocess[:dsc_handlecount]).to eq(16)
  end


  it 'should accept string-like int for dsc_handlecount' do
    dsc_windowsprocess[:dsc_handlecount] = '32'
    expect(dsc_windowsprocess[:dsc_handlecount]).to eq(32)
  end


  it 'should accept string-like int for dsc_handlecount' do
    dsc_windowsprocess[:dsc_handlecount] = '64'
    expect(dsc_windowsprocess[:dsc_handlecount]).to eq(64)
  end

  it 'should not accept array for dsc_processid' do
    expect{dsc_windowsprocess[:dsc_processid] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_processid' do
    expect{dsc_windowsprocess[:dsc_processid] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept int for dsc_processid' do
    dsc_windowsprocess[:dsc_processid] = -32
    expect(dsc_windowsprocess[:dsc_processid]).to eq(-32)
  end


  it 'should accept string-like int for dsc_processid' do
    dsc_windowsprocess[:dsc_processid] = '16'
    expect(dsc_windowsprocess[:dsc_processid]).to eq(16)
  end


  it 'should accept string-like int for dsc_processid' do
    dsc_windowsprocess[:dsc_processid] = '-16'
    expect(dsc_windowsprocess[:dsc_processid]).to eq(-16)
  end


  it 'should accept string-like int for dsc_processid' do
    dsc_windowsprocess[:dsc_processid] = '32'
    expect(dsc_windowsprocess[:dsc_processid]).to eq(32)
  end


  it 'should accept string-like int for dsc_processid' do
    dsc_windowsprocess[:dsc_processid] = '-32'
    expect(dsc_windowsprocess[:dsc_processid]).to eq(-32)
  end


  it 'should accept uint for dsc_processid' do
    dsc_windowsprocess[:dsc_processid] = -32
    expect(dsc_windowsprocess[:dsc_processid]).to eq(-32)
  end


  it 'should accept string-like int for dsc_processid' do
    dsc_windowsprocess[:dsc_processid] = '16'
    expect(dsc_windowsprocess[:dsc_processid]).to eq(16)
  end


  it 'should accept string-like int for dsc_processid' do
    dsc_windowsprocess[:dsc_processid] = '32'
    expect(dsc_windowsprocess[:dsc_processid]).to eq(32)
  end


  it 'should accept string-like int for dsc_processid' do
    dsc_windowsprocess[:dsc_processid] = '64'
    expect(dsc_windowsprocess[:dsc_processid]).to eq(64)
  end

  # Configuration PROVIDER TESTS

  describe "dsc_configuration provider tests" do

    it "should successfully instanciate the provider" do
      described_class.provider(:dsc_configuration).new(dsc_windowsprocess)
    end

    before(:each) do
      @provider = described_class.provider(:dsc_configuration).new(dsc_windowsprocess)
    end

    describe "when dscmeta_import_resource is true (default) and dscmeta_module_name existing/is defined " do

      it "should compute powershell dsc test script with Import-DscResource" do
        expect(@provider.ps_script_content('test')).to match(/Import-DscResource/)
      end

      it "should compute powershell dsc set script with Import-DscResource" do
        expect(@provider.ps_script_content('set')).to match(/Import-DscResource/)
      end

    end

    describe "when dscmeta_import_resource is false" do

      it "should compute powershell dsc test script without Import-DscResource" do
        dsc_windowsprocess[:dscmeta_import_resource] = false
        expect(@provider.ps_script_content('test')).not_to match(/Import-DscResource/)
      end

      it "should compute powershell dsc set script without Import-DscResource" do
        dsc_windowsprocess[:dscmeta_import_resource] = false
        expect(@provider.ps_script_content('set')).not_to match(/Import-DscResource/)
      end

    end

    describe "when dsc_ensure is 'present'" do

      before(:each) do
        dsc_windowsprocess.original_parameters[:dsc_ensure] = 'present'
        dsc_windowsprocess[:dsc_ensure] = 'present'
        @provider = described_class.provider(:dsc_configuration).new(dsc_windowsprocess)
      end

      it "should update :ensure to :present" do
        expect(dsc_windowsprocess[:ensure]).to eq(:present)
      end

      it "should compute powershell dsc test script in which ensure value is 'present'" do
        @provider.set_test_dsc_parameters
        expect(@provider.ps_script_content('test')).to match(/ensure = 'present'/)
      end

      it "should compute powershell dsc set script in which ensure value is 'present'" do
        @provider.set_original_dsc_parameters
        expect(@provider.ps_script_content('set')).to match(/ensure = 'present'/)
      end

    end

    describe "when dsc_ensure is 'absent'" do

      before(:each) do
        dsc_windowsprocess.original_parameters[:dsc_ensure] = 'absent'
        dsc_windowsprocess[:dsc_ensure] = 'absent'
        @provider = described_class.provider(:dsc_configuration).new(dsc_windowsprocess)
      end

      it "should update :ensure to :absent" do
        expect(dsc_windowsprocess[:ensure]).to eq(:absent)
      end

      it "should compute powershell dsc test script in which ensure value is 'present'" do
        @provider.set_test_dsc_parameters
        expect(@provider.ps_script_content('test')).to match(/ensure = 'present'/)
      end

      it "should compute powershell dsc set script in which ensure value is 'absent'" do
        @provider.set_original_dsc_parameters
        expect(@provider.ps_script_content('set')).to match(/ensure = 'absent'/)
      end

    end

  end

  # mof PROVIDERS TESTS

  describe "mof provider tests" do

    it "should successfully instanciate the provider" do
      described_class.provider(:dsc_mof).new(dsc_windowsprocess)
    end

    before(:each) do
      @provider = described_class.provider(:dsc_mof).new(dsc_windowsprocess)
    end

    it "should successfully build mof file" do
#     expect(@provider.mof_test_content).to match(/instance of MSFT_ProcessResource as $MSFT_ProcessResource1ref$/)
      expect(@provider.mof_test_content).to match(/instance of MSFT_ProcessResource/)
    end


    describe "when dsc_ensure is 'present'" do

      before(:each) do
        dsc_windowsprocess[:dsc_ensure] = 'present'
        @provider = described_class.provider(:dsc_mof).new(dsc_windowsprocess)
      end

      it "should update :ensure to :present" do
        expect(dsc_windowsprocess[:ensure]).to eq(:present)
      end

    end

    describe "when dsc_ensure is 'absent'" do

      before(:each) do
        dsc_windowsprocess[:dsc_ensure] = 'absent'
        @provider = described_class.provider(:dsc_mof).new(dsc_windowsprocess)
      end

      it "should update :ensure to :absent" do
        expect(dsc_windowsprocess[:ensure]).to eq(:absent)
      end

    end

  end
end
