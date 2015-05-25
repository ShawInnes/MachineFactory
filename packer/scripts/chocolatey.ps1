Write-Output "Installing Chocolatey"

(iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')))

choco feature enable -n=allowGlobalConfirmation

Write-Output "Chocolatey Done"

exit 0
