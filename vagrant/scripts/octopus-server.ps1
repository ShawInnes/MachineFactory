
cd "C:\Program Files\Octopus Deploy\Octopus"

& .\Octopus.Server.exe create-instance --console --instance "OctopusServer" --config "C:\Octopus\OctopusServer\OctopusServer.config"
& .\Octopus.Server.exe configure --console --instance "OctopusServer" --home "C:\Octopus" --storageMode "Embedded" --upgradeCheck "True" --upgradeCheckWithStatistics "True" --webAuthenticationMode "UsernamePassword" --webForceSSL "False" --webListenPrefixes "http://localhost:80/" --storageListenPort "10931" --commsListenPort "10943"
& .\Octopus.Server.exe service --console --instance "OctopusServer" --stop
& .\Octopus.Server.exe admin --console --instance "OctopusServer" --username "admin" --password "TopSecr3t" --wait "5000"
& .\Octopus.Server.exe license --console --instance "OctopusServer" --free --wait "5000"
& .\Octopus.Server.exe service --console --instance "OctopusServer" --install --reconfigure --start

