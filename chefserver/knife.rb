current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "chefadmin"
client_key               "#{current_dir}/chefadmin.pem"
validation_client_name   "chefdemo-validator"
validation_key           "#{current_dir}/chefdemo-validator.pem"
chef_server_url          "https://chefserver.devops/organizations/chefdemo"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]

