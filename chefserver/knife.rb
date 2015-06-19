current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "chefadmin"
client_key               "#{current_dir}/chefadmin.pem"
validation_client_name   "learningchef-validator"
validation_key           "#{current_dir}/learningchef-validator.pem"
chef_server_url          "https://ubuntu-14.04-amd64-vmwarefusion/organizations/learningchef"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]

