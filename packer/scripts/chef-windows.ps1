Write-Output "Installing Chef Client"

Start-Process -FilePath "c:\Windows\System32\msiexec.exe" -ArgumentList "/qn /i \Tools\chef-windows.msi" -Wait

Write-Output "Chef Client Done"

exit 0
