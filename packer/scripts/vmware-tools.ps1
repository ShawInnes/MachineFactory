Write-Output "Installing VMWare Tools"

Start-Process -FilePath "\tools\vmware-tools-x86_64.exe" -ArgumentList "/S /v`"/qn REBOOT=R`"" -Wait

Write-Output "VMWare Tools Done"

exit 0
