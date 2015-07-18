<# This script will install an Octopus Server >>>> 3.0 <<<< in a kind of demo mode.  It won't work on 2.xx #>

cd "C:\Program Files\Octopus Deploy\Octopus"

& .\Octopus.Server.exe create-instance --instance "OctopusServer" --config "C:\Octopus\OctopusServer.config"
& .\Octopus.Server.exe configure --instance "OctopusServer" --home "C:\Octopus" --storageConnectionString "Data Source=.\SQLEXPRESS;Initial Catalog=OctopusDeploy;Integrated Security=True" --upgradeCheck "False" --upgradeCheckWithStatistics "False" --webAuthenticationMode "UsernamePassword" --webForceSSL "False" --webListenPrefixes "http://localhost:80/" --commsListenPort "10943"
& .\Octopus.Server.exe database --instance "OctopusServer" --create --grant "NT AUTHORITY\SYSTEM"
& .\Octopus.Server.exe service --instance "OctopusServer" --stop
& .\Octopus.Server.exe admin --instance "OctopusServer" --username "admin" --password "Password01!"
& .\Octopus.Server.exe license --instance "OctopusServer" --free
& .\Octopus.Server.exe service --instance "OctopusServer" --install --reconfigure --start
