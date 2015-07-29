# mycluster.rb

require 'chef/provisioning'
require 'chef/provisioning/vagrant_driver'

with_driver 'vagrant'

options = {
  vagrant_provider: 'vmware_fusion',
  vagrant_options: {
    'vm.box' => 'servercore'
  }
}

machine_batch do
  machine 'web' do
    machine_options options
  end

  machine 'api' do
    machine_options options
  end

  machine 'db' do
    machine_options options
  end
end
