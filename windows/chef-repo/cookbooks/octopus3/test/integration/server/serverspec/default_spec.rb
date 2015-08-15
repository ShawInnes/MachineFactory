require 'spec_helper'

describe 'octopus3::server' do
  describe file('c:\\Octopus\\Tools\\Octo.exe') do
    it { should be_a_file }
  end

  describe file('c:\\Program Files\\Octopus Deploy\\Octopus\\Octopus.Server.exe') do
    it { should be_a_file }
  end

  describe package('Octopus Deploy Server') do
    it { should be_installed }
  end

  describe service('OctopusDeploy') do
    it { should be_installed }
    it { should have_start_mode('Automatic') }
  end

  describe port(10934) do
    it { should be_listening.with('tcp') }
  end
end
