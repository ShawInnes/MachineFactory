Write-Output "Installing WMF5 (Powershell)"

choco install powershell --pre

Write-Output "Done.  This will now restart."

Restart-Computer -Force
