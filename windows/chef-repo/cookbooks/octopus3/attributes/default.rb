default['octopus']['tentacle']['url'] = "https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.0.13.2386-x64.msi"
default['octopus']['tentacle']['checksum'] = "ec49dfa9d05016098a3ff4d9b4df6b42a92934e87e4518de2a4c35b46fa3f89c"
default['octopus']['tentacle']['package_name'] = "Octopus Deploy Tentacle"
default['octopus']['tentacle']['install_dir'] = "C:\\Program Files\\Octopus Deploy\\Tentacle"

default['octopus']['tentacle']['listen_port'] = "10933"

default['octopus']['tentacle']['home'] = "C:\\Octopus"
default['octopus']['tentacle']['applications'] = "C:\\Octopus\\Applications"
default['octopus']['tentacle']['name'] = "Tentacle"

default['octopus']['tentacle']['environments'] = "test"
default['octopus']['tentacle']['roles'] = "test"

default['octopus']['tools']['url'] = "https://download.octopusdeploy.com/octopus-tools/2.5.4.35/OctopusTools.2.5.4.35.zip"
default['octopus']['tools']['checksum'] = "2c1411583e5a8ba60b92b04c56e69dc9a3ee850d0ff9305ddd0187806b91f282"
default['octopus']['tools']['install_dir'] = "C:\\Octopus\\Tools"

default['octopus']['server']['url'] = "https://download.octopusdeploy.com/octopus/Octopus.3.0.13.2386-x64.msi"
default['octopus']['server']['checksum'] = "6bfa0f60f9d625e717065929996738e10f71f6eaf51a976669f8004aacaf5a3d"
default['octopus']['server']['package_name'] = "Octopus Deploy Server"
default['octopus']['server']['install_dir'] = "C:\\Program Files\\Octopus Deploy\\Octopus"

default['octopus']['server']['name'] = "OctopusServer"
default['octopus']['server']['home'] = "C:\\Octopus"
default['octopus']['server']['web_port'] = "80"
default['octopus']['server']['listen_port'] = "10934"
default['octopus']['server']['connectionstring'] = "Data Source=(local);Initial Catalog=OctopusDeploy;Integrated Security=True"

default['octopus']['server']['authentication_mode'] = "UsernamePassword" # UsernamePassword or Domain
default['octopus']['server']['admin_user'] = "admin"
default['octopus']['server']['admin_password'] = "Password01!"

## by default this will install the free license, set it to a base64 encoded string of the real license if required
default['octopus']['server']['base64license'] = nil

default['octopus']['server']['service_user'] = "#{node['hostname']}\\packer"
default['octopus']['server']['service_password'] = "packer"

default['octopus']['server']['thumbprint'] = nil
default['octopus']['server']['address'] = "http://test.octopusdeploy.com/"

default['octopus']['api']['url'] = "http://test.octopusdeploy.com/api"
default['octopus']['api']['key'] = nil
