# Survival beyond the DMZ

```
gem install gemirro
```

## Configure gemirro cache
```
gemirro init /srv/http/mirror.com/
```

## On Remote Nodes
```
gem sources -r "https://rubygems.org/"
gem sources -a "http://gems.devops/"
```

## Run rspec
```
$ rspec spec --color --format documentation

role-sqlserver::default
  When all attributes are default, on an unspecified platform
    raises an error
  When sqlserver source is set
    creates cached download file
    creates cached configuration file
    executes powershell script

```

## Trick to getting Kitchen YAML working on VMWare Fusion

```
driver:
  name: vagrant
  gui: true
  provider: vmware_fusion

provisioner:
  name: chef_zero

platforms:
  - name: windows-2012r2-20150813
```

## Trick to getting ServerSpec working for Windows
```
require 'serverspec'

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
else
  set :backend, :cmd
  set :os, family: 'windows'
end
```

## To execute

```
rspec --color --format documentation spec/unit/recipes/default_spec.rb
```

## Test Kitchen Run

```
shaw.innes@ta020033mac role-sqlserver (master) $ kitchen test
-----> Starting Kitchen (v1.4.0)
-----> Cleaning up any prior instances of <default-windows-2012r2-20150813>
-----> Destroying <default-windows-2012r2-20150813>...
       ==> default: Stopping the VMware VM...
       ==> default: Deleting the VM...
       Vagrant instance <default-windows-2012r2-20150813> destroyed.
       Finished destroying <default-windows-2012r2-20150813> (0m16.43s).
-----> Testing <default-windows-2012r2-20150813>
-----> Creating <default-windows-2012r2-20150813>...
       Bringing machine 'default' up with 'vmware_fusion' provider...
       ==> default: Cloning VMware VM: 'windows-2012r2-20150813'. This can take some time...
       ==> default: Verifying vmnet devices are healthy...
       ==> default: Preparing network adapters...
       ==> default: Starting the VMware VM...
       ==> default: Waiting for machine to boot. This may take a few minutes...
           default: WinRM address: 0:5985
           default: WinRM username: packer
           default: WinRM transport: plaintext
       ==> default: Machine booted and ready!
       ==> default: Forwarding ports...
           default: -- 3389 => 3389
           default: -- 5985 => 5985
       ==> default: Configuring network adapters within the VM...
       ==> default: Configuring secondary network adapters through VMware
       ==> default: on Windows is not yet supported. You will need to manually
       ==> default: configure the network adapter.
       ==> default: Machine not provisioned because `--no-provision` is specified.
       [WinRM] Established
       Vagrant instance <default-windows-2012r2-20150813> created.
       Finished creating <default-windows-2012r2-20150813> (2m3.49s).
-----> Converging <default-windows-2012r2-20150813>...
       Preparing files for transfer
       Preparing dna.json
       Resolving cookbook dependencies with Berkshelf 3.2.4...
       Removing non-cookbook files before transfer
       Preparing validation.pem
       Preparing client.rb
-----> Chef Omnibus installation detected (install only if missing)
       Transferring files to <default-windows-2012r2-20150813>
       Starting Chef Client, version 12.4.1
       Creating a new client identity for default-windows-2012r2-20150813 using the validator key.
       [2015-08-14T05:39:43-07:00] WARN: Child with name 'dna.json' found in multiple directories: C:/Users/packer/AppData/Local/Temp/kitchen/dna.json and C:/Users/packer/AppData/Local/Temp/kitchen/dna.json
       [2015-08-14T05:39:43-07:00] WARN: Child with name 'dna.json' found in multiple directories: C:/Users/packer/AppData/Local/Temp/kitchen/dna.json and C:/Users/packer/AppData/Local/Temp/kitchen/dna.json
       resolving cookbooks for run list: ["role-sqlserver::default"]
       [2015-08-14T05:39:43-07:00] WARN: Child with name 'dna.json' found in multiple directories: C:/Users/packer/AppData/Local/Temp/kitchen/dna.json and C:/Users/packer/AppData/Local/Temp/kitchen/dna.json
       Synchronizing Cookbooks:
         - role-sqlserver
         - windows
         - chef_handler
       Compiling Cookbooks...
       [2015-08-14T05:39:44-07:00] WARN: You are overriding windows_package on {:os=>"windows"} with Chef::Resource::WindowsCookbookPackage: used to be Chef::Resource::WindowsPackage. Use override: true if this is what you intended.
       Converging 3 resources
       Recipe: role-sqlserver::default

           - create new file C:\Users\packer\AppData\Local\Temp\kitchen\cache/en_sql_server_2014_developer_edition_x64_dvd_3940406.iso
           - update content in file C:\Users\packer\AppData\Local\Temp\kitchen\cache/en_sql_server_2014_developer_edition_x64_dvd_3940406.iso from none to 3b27bf
           (file sizes exceed 10000000 bytes, diff output suppressed)
         * template[C:\Users\packer\AppData\Local\Temp\kitchen\cache/ConfigurationFile.ini] action create
           - create new file C:\Users\packer\AppData\Local\Temp\kitchen\cache/ConfigurationFile.ini
           - update content in file C:\Users\packer\AppData\Local\Temp\kitchen\cache/ConfigurationFile.ini from none to 607970
           - execute "powershell.exe" -NoLogo -NonInteractive -NoProfile -ExecutionPolicy Bypass -InputFormat None -File "C:/Users/packer/AppData/Local/Temp/chef-script20150814-2612-1pbmqta.ps1"

       Running handlers:
       Running handlers complete
       Chef Client finished, 3/3 resources updated in 341.258275 seconds
       Finished converging <default-windows-2012r2-20150813> (6m51.58s).
-----> Setting up <default-windows-2012r2-20150813>...
       Finished setting up <default-windows-2012r2-20150813> (0m0.00s).
-----> Verifying <default-windows-2012r2-20150813>...
       Preparing files for transfer
-----> Installing Busser (busser)
       Successfully installed thor-0.19.0
       Successfully installed busser-0.7.1
       2 gems installed
-----> Setting up Busser
       Creating BUSSER_ROOT in C:\Users\packer\AppData\Local\Temp\verifier
       Creating busser binstub
       Installing Busser plugins: busser-serverspec
       Plugin serverspec installed (version 0.5.7)
-----> Running postinstall for serverspec plugin
       Suite path directory C:/Users/packer/AppData/Local/Temp/verifier/suites does not exist, skipping.
       Transferring files to <default-windows-2012r2-20150813>
-----> Running serverspec test suite
-----> Installing Serverspec..
-----> serverspec installed (version 2.21.0)

       role-sqlserver::default
         Service "SQL Server (MSSQLSERVER)"
           should be installed
           should have start mode "Automatic"
         Package "Microsoft SQL Server 2014 (64-bit)"
           should be installed
         Port "1433"
           should be listening

       Finished in 1.94 seconds (files took 0.48143 seconds to load)
       4 examples, 0 failures

       C:/opscode/chef/embedded/bin/ruby.exe -IC:/Users/packer/AppData/Local/Temp/verifier/suites/serverspec -I'C:/Users/packer/AppData/Local/Temp/verifier/gems/gems/rspec-support-3.3.0/lib';'C:/Users/packer/AppData/Local/Temp/verifier/gems/gems/rspec-core-3.3.2/lib' 'C:/Users/packer/AppData/Local/Temp/verifier/gems/gems/rspec-core-3.3.2/exe/rspec' --pattern 'C:/Users/packer/AppData/Local/Temp/verifier/suites/serverspec/**/*_spec.rb' --color --format documentation --default-path C:/Users/packer/AppData/Local/Temp/verifier/suites/serverspec
       Finished verifying <default-windows-2012r2-20150813> (1m8.70s).
-----> Destroying <default-windows-2012r2-20150813>...
       ==> default: Stopping the VMware VM...
       ==> default: Deleting the VM...
       Vagrant instance <default-windows-2012r2-20150813> destroyed.
       Finished destroying <default-windows-2012r2-20150813> (0m13.77s).
       Finished testing <default-windows-2012r2-20150813> (10m33.98s).
-----> Kitchen is finished. (10m35.74s)
```
