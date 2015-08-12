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
    'vm.box' => 'windows-2012r2-20150811',
    'vm.guest' => :windows,
    'vm.communicator' => :winrm
  }
}

machine 'web' do
  machine_options options
end
