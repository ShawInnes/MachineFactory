# mycluster.rb

require 'chef/provisioning'
require 'chef/provisioning/vagrant_driver'

with_driver 'vagrant'

options = {
  vagrant_provider: 'vmware_fusion',
  vagrant_options: {
    'winrm.port' => 5985,
    'winrm.guest_port' => 5985,
    'winrm.username' => 'packer',
    'winrm.password' => 'packer',
    'vm.box' => 'server2012r2_20150725.1',
    'vm.guest' => :windows,
    'vm.communicator' => :winrm
  }
}

machine 'web' do
  machine_options options
end
