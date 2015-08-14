require 'spec_helper'

describe 'role-sqlserver::default' do
  describe service('SQL Server (MSSQLSERVER)') do
    it { should be_installed }
    it { should have_start_mode('Automatic') }
  end

  describe package('Microsoft SQL Server 2014 (64-bit)') do
    it { should be_installed }
  end

  describe port(1433) do
    it { should be_listening.with('tcp') }
  end
end
