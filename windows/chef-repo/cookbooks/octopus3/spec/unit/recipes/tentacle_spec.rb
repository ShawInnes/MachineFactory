#
# Cookbook Name:: octopus3
# Spec:: tentacle
#
# Copyright (c) 2015 Shaw Innes, All Rights Reserved.

require 'spec_helper'

describe 'octopus3::tentacle' do
  context 'When all attributes are default, on an `windows` platform, `2012r2` version' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012R2')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end
  end
end
