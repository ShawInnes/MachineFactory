require 'spec_helper'

describe 'octopus3::tentacle' do
  describe file('c:\\Octopus\\Tools\\Octo.exe') do
    it { should be_a_file }
  end

  describe package('Octopus Deploy Server') do
    it { should be_installed }
  end

  describe service('Octopus Deploy Server') do
    it { should be_installed }
    it { should have_start_mode('Automatic') }
  end

  #describe port(80) do
  #  it { should be_listening.with('tcp') }
  #end

  #describe port(10933) do
  #  it { should be_listening.with('tcp') }
  #end
end
