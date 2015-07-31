# mycluster.rb

require 'chef/provisioning'
require 'chef/provisioning/vagrant_driver'

with_driver 'vagrant'

vagrant_box 'phusion/ubuntu-14.04-amd64' 

options = {
  vagrant_provider: 'vmware_fusion',
  vagrant_options: {
    'vm.box' => 'phusion/ubuntu-14.04-amd64'
  }
}

machine_batch do
  machine 'web' do
    machine_options options
    recipe 'apache'
    converge true
  end
end
